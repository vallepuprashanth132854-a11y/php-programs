<?php
$base = '';
$page_title = 'Home';
require_once __DIR__ . '/includes/bootstrap.php';

$search = trim($_GET['search'] ?? '');
$city = $_SESSION['city'] ?? 'Mumbai';

if ($search !== '') {
    $stmt = $pdo->prepare("SELECT * FROM movies WHERE status='now_showing' AND title LIKE ? ORDER BY release_date DESC");
    $stmt->execute(["%$search%"]);
    $now_showing = $stmt->fetchAll();
    $coming_soon = [];
    $city_has_no_movies = false;
} else {
    // Prefer movies that actually have a show in the selected city
    $stmt = $pdo->prepare("
        SELECT DISTINCT m.*
        FROM movies m
        JOIN shows s ON s.movie_id = m.id
        JOIN screens sc ON s.screen_id = sc.id
        JOIN theaters t ON sc.theater_id = t.id
        WHERE m.status = 'now_showing' AND t.city = ?
        ORDER BY m.release_date DESC
    ");
    $stmt->execute([$city]);
    $now_showing = $stmt->fetchAll();
    $city_has_no_movies = empty($now_showing);

    // Fallback: if nothing is playing in this city yet, show everything so the demo never looks empty
    if ($city_has_no_movies) {
        $now_showing = $pdo->query("SELECT * FROM movies WHERE status='now_showing' ORDER BY release_date DESC")->fetchAll();
    }

    $coming_soon = $pdo->query("SELECT * FROM movies WHERE status='coming_soon' ORDER BY release_date ASC")->fetchAll();
}

function movie_card(array $m, bool $comingSoon = false): void {
    $link = $comingSoon ? '#' : 'movie.php?id=' . $m['id'];
    $poster = poster_background($m);
    $genres = array_map('trim', explode(',', $m['genre']));
    ?>
    <a href="<?= $link ?>" class="movie-card" data-genre="<?= e(strtolower($genres[0] ?? '')) ?>" data-lang="<?= e(strtolower($m['language'])) ?>" <?= $comingSoon ? 'onclick="return false;" style="cursor:default;"' : '' ?>>
        <div class="movie-poster" style="<?= $poster['style'] ?>">
            <?php if (!$poster['has_image']): ?>
                <span class="poster-title"><?= e($m['title']) ?></span>
            <?php endif; ?>
            <?php if ((float)$m['rating'] >= 8.5): ?>
                <span class="poster-hot-badge">🔥 Trending</span>
            <?php endif; ?>
            <?php if ((float)$m['rating'] > 0): ?>
                <span class="movie-rating">★ <?= e($m['rating']) ?></span>
            <?php endif; ?>
            <?php if ($comingSoon): ?>
                <span class="poster-soon-badge">Coming Soon</span>
            <?php else: ?>
                <span class="poster-hover-overlay">Book Now →</span>
            <?php endif; ?>
        </div>
        <div class="movie-info">
            <h3><?= e($m['title']) ?></h3>
            <p><?= e($m['genre']) ?> · <?= e($m['language']) ?></p>
        </div>
    </a>
    <?php
}

// Build filter chip lists from the movies actually on screen
$genre_set = [];
$lang_set = [];
foreach ($now_showing as $m) {
    foreach (explode(',', $m['genre']) as $g) {
        $g = trim($g);
        if ($g !== '') $genre_set[strtolower($g)] = $g;
    }
    $lang_set[strtolower($m['language'])] = $m['language'];
}

require_once __DIR__ . '/includes/header.php';
?>

<?php if ($search === ''): ?>
<div class="hero-banner">
    <div class="hero-text">
        <h1>Book tickets for the latest movies</h1>
        <p>Now showing in <strong><?= e($city) ?></strong> — pick a movie, choose your seats, and enjoy the show.</p>
        <button type="button" class="btn hero-city-btn" onclick="document.getElementById('cityTrigger').click();">
            Change city
        </button>
    </div>
</div>
<?php endif; ?>

<div class="section-title">
    <span><?= $search !== '' ? 'Search results for "' . e($search) . '"' : 'Now Showing' ?></span>
</div>

<?php if ($search === '' && $city_has_no_movies): ?>
    <p class="city-empty-note">No shows are listed in <?= e($city) ?> yet, so here's what's playing across other cities.</p>
<?php endif; ?>

<?php if ($search === '' && !empty($now_showing) && (count($genre_set) > 1 || count($lang_set) > 1)): ?>
<div class="filter-bar" id="filterBar">
    <span class="filter-chip active" data-filter-genre="all" data-filter-lang="all">All</span>
    <?php foreach ($genre_set as $key => $label): ?>
        <span class="filter-chip" data-filter-genre="<?= e($key) ?>"><?= e($label) ?></span>
    <?php endforeach; ?>
    <span class="filter-divider"></span>
    <?php foreach ($lang_set as $key => $label): ?>
        <span class="filter-chip filter-chip-lang" data-filter-lang="<?= e($key) ?>"><?= e($label) ?></span>
    <?php endforeach; ?>
</div>
<?php endif; ?>

<?php if (empty($now_showing)): ?>
    <p style="color:#8b93a6;">No movies found.</p>
<?php else: ?>
    <div class="movie-grid" id="movieGrid">
        <?php foreach ($now_showing as $m) movie_card($m); ?>
    </div>
    <p class="filter-no-results" id="filterNoResults" style="display:none;">No movies match that filter.</p>
<?php endif; ?>

<?php if (!empty($coming_soon)): ?>
    <div class="section-title"><span>Coming Soon</span></div>
    <div class="movie-grid">
        <?php foreach ($coming_soon as $m) movie_card($m, true); ?>
    </div>
<?php endif; ?>

<?php if (!empty($genre_set) && count($genre_set) + count($lang_set) > 1): ?>
<script>
(function () {
    var bar = document.getElementById('filterBar');
    if (!bar) return;
    var chips = bar.querySelectorAll('.filter-chip');
    var cards = document.querySelectorAll('#movieGrid .movie-card');
    var noResults = document.getElementById('filterNoResults');
    var activeGenre = 'all';
    var activeLang = 'all';

    function apply() {
        var visible = 0;
        cards.forEach(function (card) {
            var matchGenre = activeGenre === 'all' || card.dataset.genre === activeGenre;
            var matchLang = activeLang === 'all' || card.dataset.lang === activeLang;
            var show = matchGenre && matchLang;
            card.style.display = show ? '' : 'none';
            if (show) visible++;
        });
        noResults.style.display = visible === 0 ? '' : 'none';
    }

    chips.forEach(function (chip) {
        chip.addEventListener('click', function () {
            if (this.dataset.filterGenre === 'all') {
                activeGenre = 'all';
                activeLang = 'all';
                chips.forEach(function (c) { c.classList.remove('active'); });
                this.classList.add('active');
            } else if (this.classList.contains('filter-chip-lang')) {
                activeLang = this.classList.contains('active') ? 'all' : this.dataset.filterLang;
                chips.forEach(function (c) { if (c.classList.contains('filter-chip-lang')) c.classList.remove('active'); });
                if (activeLang !== 'all') this.classList.add('active');
            } else {
                activeGenre = this.classList.contains('active') ? 'all' : this.dataset.filterGenre;
                chips.forEach(function (c) { if (!c.classList.contains('filter-chip-lang') && c.dataset.filterGenre !== 'all') c.classList.remove('active'); });
                if (activeGenre !== 'all') this.classList.add('active');
            }
            if (activeGenre === 'all' && activeLang === 'all') {
                chips.forEach(function (c) { c.classList.remove('active'); });
                bar.querySelector('[data-filter-genre="all"]').classList.add('active');
            } else {
                bar.querySelector('[data-filter-genre="all"]').classList.remove('active');
            }
            apply();
        });
    });
})();
</script>
<?php endif; ?>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
