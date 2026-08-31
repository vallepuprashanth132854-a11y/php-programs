<?php
$base = '../';
$page_title = 'Manage Movies';
require_once __DIR__ . '/../includes/bootstrap.php';
require_admin();

const MAX_POSTER_BYTES = 5 * 1024 * 1024; // 5MB
const ALLOWED_POSTER_MIMES = [
    'image/jpeg' => 'jpg',
    'image/png'  => 'png',
    'image/webp' => 'webp',
    'image/gif'  => 'gif',
];

// Deletes a locally-uploaded poster file (never touches external URLs)
function delete_local_poster(?string $posterUrl): void {
    if (!$posterUrl) return;
    if (preg_match('#^https?://#i', $posterUrl)) return; // external link, leave it alone
    if (strpos($posterUrl, 'assets/images/posters/') !== 0) return; // safety: only our upload folder
    $full = __DIR__ . '/../' . $posterUrl;
    if (is_file($full)) @unlink($full);
}

// Handle delete
if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    $stmt = $pdo->prepare("SELECT poster_url FROM movies WHERE id = ?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if ($row) delete_local_poster($row['poster_url']);

    $stmt = $pdo->prepare("DELETE FROM movies WHERE id = ?");
    $stmt->execute([$id]);
    flash('success', 'Movie deleted.');
    redirect('movies.php');
}

// Handle "remove poster" (keeps the movie, just clears its image back to the auto gradient)
if (isset($_GET['remove_poster'])) {
    $id = (int)$_GET['remove_poster'];
    $stmt = $pdo->prepare("SELECT poster_url FROM movies WHERE id = ?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if ($row) {
        delete_local_poster($row['poster_url']);
        $stmt = $pdo->prepare("UPDATE movies SET poster_url = '' WHERE id = ?");
        $stmt->execute([$id]);
        flash('success', 'Poster removed.');
    }
    redirect('movies.php?edit=' . $id);
}

// Handle add/edit
$editing = null;
if (isset($_GET['edit'])) {
    $stmt = $pdo->prepare("SELECT * FROM movies WHERE id = ?");
    $stmt->execute([(int)$_GET['edit']]);
    $editing = $stmt->fetch();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = (int)($_POST['id'] ?? 0);
    $title = trim($_POST['title'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $genre = trim($_POST['genre'] ?? '');
    $language = trim($_POST['language'] ?? '');
    $duration = (int)($_POST['duration_mins'] ?? 120);
    $poster_url = trim($_POST['poster_url'] ?? '');
    $release_date = $_POST['release_date'] ?? date('Y-m-d');
    $rating = (float)($_POST['rating'] ?? 0);
    $status = $_POST['status'] ?? 'now_showing';

    if ($title === '') {
        flash('error', 'Title is required.');
        redirect('movies.php' . ($id > 0 ? '?edit=' . $id : ''));
    }

    // Handle a poster file upload — takes priority over any pasted URL
    if (!empty($_FILES['poster_image']['name'])) {
        $file = $_FILES['poster_image'];

        if ($file['error'] !== UPLOAD_ERR_OK) {
            flash('error', 'Poster upload failed (error code ' . (int)$file['error'] . '). Please try again.');
            redirect('movies.php' . ($id > 0 ? '?edit=' . $id : ''));
        }
        if ($file['size'] > MAX_POSTER_BYTES) {
            flash('error', 'Poster image must be under 5MB.');
            redirect('movies.php' . ($id > 0 ? '?edit=' . $id : ''));
        }

        $mime = function_exists('mime_content_type') ? mime_content_type($file['tmp_name']) : ($file['type'] ?? '');
        if (!isset(ALLOWED_POSTER_MIMES[$mime])) {
            flash('error', 'Poster must be a JPG, PNG, WEBP or GIF image.');
            redirect('movies.php' . ($id > 0 ? '?edit=' . $id : ''));
        }

        $destDir = poster_upload_dir();
        if (!is_dir($destDir)) mkdir($destDir, 0775, true);

        $ext = ALLOWED_POSTER_MIMES[$mime];
        $filename = 'poster_' . uniqid('', true) . '.' . $ext;

        if (!move_uploaded_file($file['tmp_name'], $destDir . $filename)) {
            flash('error', 'Could not save the uploaded poster. Check that assets/images/posters/ is writable.');
            redirect('movies.php' . ($id > 0 ? '?edit=' . $id : ''));
        }

        // Replacing an existing local poster? Clean up the old file.
        if ($id > 0) {
            $stmt = $pdo->prepare("SELECT poster_url FROM movies WHERE id = ?");
            $stmt->execute([$id]);
            $old = $stmt->fetch();
            if ($old) delete_local_poster($old['poster_url']);
        }

        $poster_url = 'assets/images/posters/' . $filename;
    }

    if ($id > 0) {
        $stmt = $pdo->prepare("UPDATE movies SET title=?, description=?, genre=?, language=?, duration_mins=?, poster_url=?, release_date=?, rating=?, status=? WHERE id=?");
        $stmt->execute([$title, $description, $genre, $language, $duration, $poster_url, $release_date, $rating, $status, $id]);
        flash('success', 'Movie updated.');
    } else {
        $stmt = $pdo->prepare("INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES (?,?,?,?,?,?,?,?,?)");
        $stmt->execute([$title, $description, $genre, $language, $duration, $poster_url, $release_date, $rating, $status]);
        flash('success', 'Movie added.');
    }
    redirect('movies.php');
}

$movies = $pdo->query("SELECT * FROM movies ORDER BY created_at DESC")->fetchAll();
$editingPoster = $editing ? poster_background($editing) : null;

require_once __DIR__ . '/../includes/header.php';
?>

<div class="admin-nav">
    <a href="index.php">Dashboard</a>
    <a href="movies.php" class="active">Movies</a>
    <a href="theaters.php">Theaters</a>
    <a href="shows.php">Shows</a>
    <a href="bookings.php">Bookings</a>
    <a href="fetch_posters.php">Fetch Posters</a>
</div>

<div class="section-title"><span><?= $editing ? 'Edit Movie' : 'Add New Movie' ?></span></div>

<div class="form-card" style="max-width:100%;">
    <form method="POST" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<?= $editing['id'] ?? '' ?>">
        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:16px;">
            <div class="form-group">
                <label>Title *</label>
                <input type="text" name="title" value="<?= e($editing['title'] ?? '') ?>" required>
            </div>
            <div class="form-group">
                <label>Genre</label>
                <input type="text" name="genre" value="<?= e($editing['genre'] ?? '') ?>" placeholder="Action, Thriller">
            </div>
            <div class="form-group">
                <label>Language</label>
                <input type="text" name="language" value="<?= e($editing['language'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label>Duration (mins)</label>
                <input type="number" name="duration_mins" value="<?= e((string)($editing['duration_mins'] ?? 120)) ?>">
            </div>
            <div class="form-group">
                <label>Release Date</label>
                <input type="date" name="release_date" value="<?= e($editing['release_date'] ?? date('Y-m-d')) ?>">
            </div>
            <div class="form-group">
                <label>Rating (0-10)</label>
                <input type="number" step="0.1" min="0" max="10" name="rating" value="<?= e((string)($editing['rating'] ?? 0)) ?>">
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="status">
                    <option value="now_showing" <?= ($editing['status'] ?? '') === 'now_showing' ? 'selected' : '' ?>>Now Showing</option>
                    <option value="coming_soon" <?= ($editing['status'] ?? '') === 'coming_soon' ? 'selected' : '' ?>>Coming Soon</option>
                </select>
            </div>
            <div class="form-group">
                <label>External poster URL <span style="font-weight:400; color:var(--muted);">(optional — skip this if uploading a file below)</span></label>
                <input type="text" name="poster_url" value="<?= e($editing['poster_url'] ?? '') ?>" placeholder="https://... or leave blank">
            </div>
        </div>

        <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="3"><?= e($editing['description'] ?? '') ?></textarea>
        </div>

        <div class="form-group poster-upload-group">
            <label>Poster image</label>
            <div class="poster-upload-row">
                <div class="poster-preview" id="posterPreview" style="<?= $editingPoster['style'] ?? '' ?>">
                    <?php if (!$editingPoster || !$editingPoster['has_image']): ?>
                        <span class="poster-preview-empty">No poster yet</span>
                    <?php endif; ?>
                </div>
                <div class="poster-upload-controls">
                    <input type="file" name="poster_image" id="posterInput" accept="image/jpeg,image/png,image/webp,image/gif">
                    <p class="poster-upload-hint">JPG, PNG, WEBP or GIF · up to 5MB. Uploading a file replaces any URL above.</p>
                    <?php if ($editing && !empty($editing['poster_url']) && strpos($editing['poster_url'], 'assets/images/posters/') === 0): ?>
                        <a href="?remove_poster=<?= $editing['id'] ?>" class="btn-outline" style="display:inline-block; padding:7px 14px; font-size:13px;" onclick="return confirm('Remove this poster image?')">Remove current poster</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>

        <button type="submit" class="btn"><?= $editing ? 'Update Movie' : 'Add Movie' ?></button>
        <?php if ($editing): ?><a href="movies.php" class="btn-outline" style="padding:10px 20px; display:inline-block;">Cancel</a><?php endif; ?>
    </form>
</div>

<div class="section-title"><span>All Movies</span></div>
<table>
    <tr><th>Poster</th><th>Title</th><th>Genre</th><th>Language</th><th>Status</th><th>Rating</th><th>Actions</th></tr>
    <?php foreach ($movies as $m): $p = poster_background($m); ?>
    <tr>
        <td><div class="admin-thumb" style="<?= $p['style'] ?>"></div></td>
        <td><?= e($m['title']) ?></td>
        <td><?= e($m['genre']) ?></td>
        <td><?= e($m['language']) ?></td>
        <td><?= $m['status'] === 'now_showing' ? 'Now Showing' : 'Coming Soon' ?></td>
        <td><?= e($m['rating']) ?></td>
        <td>
            <a href="?edit=<?= $m['id'] ?>" style="color:#1976d2;">Edit</a> ·
            <a href="?delete=<?= $m['id'] ?>" style="color:#d2232a;" onclick="return confirm('Delete this movie and all its shows?')">Delete</a>
        </td>
    </tr>
    <?php endforeach; ?>
</table>

<script>
(function () {
    var input = document.getElementById('posterInput');
    var preview = document.getElementById('posterPreview');
    if (!input || !preview) return;
    input.addEventListener('change', function () {
        var file = this.files && this.files[0];
        if (!file) return;
        var reader = new FileReader();
        reader.onload = function (e) {
            preview.style.backgroundImage = 'url(' + e.target.result + ')';
            preview.style.backgroundSize = 'cover';
            preview.style.backgroundPosition = 'center';
            preview.innerHTML = '';
        };
        reader.readAsDataURL(file);
    });
})();
</script>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
