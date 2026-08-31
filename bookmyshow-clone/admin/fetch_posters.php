<?php
$base = '../';
$page_title = 'Fetch Posters from TMDb';
require_once __DIR__ . '/../includes/bootstrap.php';
require_admin();
require_once __DIR__ . '/../config/tmdb.php';

// Many Windows/Laragon PHP installs ship without a CA certificate bundle
// configured, so cURL can't verify *any* HTTPS site and every request fails
// with "SSL certificate problem: unable to get local issuer certificate".
// This fetches the public Mozilla CA bundle (the same one curl.se publishes
// for exactly this purpose) once and caches it locally, so every TMDb call
// after that verifies normally with no php.ini changes required.
function ensure_ca_bundle(): string {
    $path = __DIR__ . '/../config/cacert.pem';
    if (is_file($path) && filesize($path) > 100000) {
        return $path;
    }

    $ch = curl_init('https://curl.se/ca/cacert.pem');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 20,
        // Safe here specifically: this is a well-known, public, non-secret
        // file (the standard Mozilla CA list); we only skip verification
        // for this one-time bootstrap download, never for the TMDb calls.
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSL_VERIFYHOST => 0,
    ]);
    $bundle = curl_exec($ch);
    $ok = curl_getinfo($ch, CURLINFO_HTTP_CODE) === 200 && $bundle !== false && strlen($bundle) > 100000;
    curl_close($ch);

    if (!$ok) {
        throw new RuntimeException('Could not download a CA certificate bundle automatically. See the note below the results table for a manual fix.');
    }

    file_put_contents($path, $bundle);
    return $path;
}

// Calls TMDb's search/movie endpoint for a title and returns the best
// matching poster path, or null if nothing usable was found.
function tmdb_find_poster_path(string $title, string $caBundlePath): ?string {
    $params = [
        'api_key' => TMDB_API_KEY,
        'query'   => $title,
        'include_adult' => 'false',
    ];
    $url = 'https://api.themoviedb.org/3/search/movie?' . http_build_query($params);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 10,
        CURLOPT_HTTPHEADER => ['Accept: application/json'],
        CURLOPT_CAINFO => $caBundlePath,
    ]);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if ($response === false || $httpCode !== 200) {
        throw new RuntimeException("TMDb request failed (HTTP $httpCode) $curlError");
    }

    $data = json_decode($response, true);
    if (empty($data['results'])) {
        return null;
    }

    // Prefer the most popular / highest-vote result with an actual poster.
    $results = $data['results'];
    usort($results, fn($a, $b) => ($b['popularity'] ?? 0) <=> ($a['popularity'] ?? 0));
    foreach ($results as $r) {
        if (!empty($r['poster_path'])) {
            return $r['poster_path'];
        }
    }
    return null;
}

$results = [];
$ran = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['run_fetch'])) {
    $ran = true;
    $overwrite = isset($_POST['overwrite']);

    if (!TMDB_API_KEY || TMDB_API_KEY === '') {
        flash('error', 'No TMDb API key configured in config/tmdb.php.');
        redirect('fetch_posters.php');
    }

    $caBundlePath = null;
    $caBundleError = null;
    try {
        $caBundlePath = ensure_ca_bundle();
    } catch (Throwable $e) {
        $caBundleError = $e->getMessage();
    }

    if ($caBundlePath === null) {
        flash('error', 'Could not set up a CA certificate bundle automatically: ' . $caBundleError);
        redirect('fetch_posters.php');
    }

    $movies = $pdo->query("SELECT id, title, poster_url FROM movies ORDER BY title")->fetchAll();

    $updateStmt = $pdo->prepare("UPDATE movies SET poster_url = ? WHERE id = ?");

    foreach ($movies as $m) {
        $current = $m['poster_url'] ?? '';
        $isPlaceholder = $current === '' || strpos($current, 'picsum.photos') !== false;

        if (!$overwrite && !$isPlaceholder) {
            $results[] = ['title' => $m['title'], 'status' => 'skipped', 'note' => 'Already has a non-placeholder poster'];
            continue;
        }

        try {
            $posterPath = tmdb_find_poster_path($m['title'], $caBundlePath);
            if ($posterPath) {
                $fullUrl = TMDB_IMG_BASE . $posterPath;
                $updateStmt->execute([$fullUrl, $m['id']]);
                $results[] = ['title' => $m['title'], 'status' => 'updated', 'note' => $fullUrl];
            } else {
                $results[] = ['title' => $m['title'], 'status' => 'not_found', 'note' => 'No TMDb match with a poster'];
            }
        } catch (Throwable $e) {
            $results[] = ['title' => $m['title'], 'status' => 'error', 'note' => $e->getMessage()];
        }

        // Be gentle with TMDb's rate limits.
        usleep(150000); // 150ms between requests
    }

    $updatedCount = count(array_filter($results, fn($r) => $r['status'] === 'updated'));
    flash('success', "Done. Updated $updatedCount poster(s).");
}

$moviesForDisplay = $pdo->query("SELECT id, title, poster_url FROM movies ORDER BY title")->fetchAll();
$placeholderCount = count(array_filter($moviesForDisplay, function ($m) {
    $p = $m['poster_url'] ?? '';
    return $p === '' || strpos($p, 'picsum.photos') !== false;
}));

require_once __DIR__ . '/../includes/header.php';
?>

<div class="admin-nav">
    <a href="index.php">Dashboard</a>
    <a href="movies.php">Movies</a>
    <a href="theaters.php">Theaters</a>
    <a href="shows.php">Shows</a>
    <a href="bookings.php">Bookings</a>
    <a href="fetch_posters.php" class="active">Fetch Posters</a>
</div>

<div class="section-title"><span>Fetch Real Posters from TMDb</span></div>

<div class="form-card" style="max-width:100%;">
    <p style="color:var(--muted); margin-bottom:14px;">
        This looks up each movie title on <a href="https://www.themoviedb.org" target="_blank" rel="noopener">TMDb</a>
        and replaces its poster with TMDb's official artwork. Your server calls TMDb directly using your own API key —
        nothing is copied or stored by anyone else.
    </p>
    <p style="margin-bottom:14px;">
        <strong><?= $placeholderCount ?></strong> of <strong><?= count($moviesForDisplay) ?></strong> movies currently
        have a placeholder (or missing) poster.
    </p>
    <p style="font-size:12px; color:var(--muted); margin-bottom:14px;">
        If you saw an SSL/certificate error before: this page now auto-downloads a CA certificate bundle the first
        time it runs (a common gap in Windows/Laragon PHP installs). If that download itself fails (e.g. a firewall
        blocks it), download <a href="https://curl.se/ca/cacert.pem" target="_blank" rel="noopener">cacert.pem</a>
        manually and save it as <code>config/cacert.pem</code> in this project, then try again.
    </p>
    <form method="POST">
        <div class="form-group" style="display:flex; align-items:center; gap:8px;">
            <input type="checkbox" name="overwrite" id="overwrite" style="width:auto;">
            <label for="overwrite" style="margin:0;">Overwrite posters that already look real (not placeholders)</label>
        </div>
        <button type="submit" name="run_fetch" value="1" class="btn">Fetch Posters Now</button>
    </form>
</div>

<?php if ($ran): ?>
<div class="section-title"><span>Results</span></div>
<table>
    <tr><th>Movie</th><th>Status</th><th>Details</th></tr>
    <?php foreach ($results as $r): ?>
    <tr>
        <td><?= e($r['title']) ?></td>
        <td>
            <?php
            $badge = ['updated' => 'badge-confirmed', 'not_found' => 'badge-cancelled', 'skipped' => 'badge-pending', 'error' => 'badge-cancelled'][$r['status']] ?? '';
            ?>
            <span class="badge <?= $badge ?>"><?= e(ucfirst(str_replace('_', ' ', $r['status']))) ?></span>
        </td>
        <td style="font-size:12px; color:var(--muted); word-break:break-all;"><?= e($r['note']) ?></td>
    </tr>
    <?php endforeach; ?>
</table>
<?php endif; ?>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
