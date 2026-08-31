<?php
$base = '../';
$page_title = 'Manage Shows';
require_once __DIR__ . '/../includes/bootstrap.php';
require_admin();

if (isset($_GET['delete'])) {
    $stmt = $pdo->prepare("DELETE FROM shows WHERE id = ?");
    $stmt->execute([(int)$_GET['delete']]);
    flash('success', 'Show deleted.');
    redirect('shows.php');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $movie_id = (int)$_POST['movie_id'];
    $screen_id = (int)$_POST['screen_id'];
    $show_date = $_POST['show_date'];
    $show_time = $_POST['show_time'];
    $price_regular = (float)$_POST['price_regular'];
    $price_premium = (float)$_POST['price_premium'];
    $price_recliner = (float)$_POST['price_recliner'];

    $stmt = $pdo->prepare("INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) VALUES (?,?,?,?,?,?,?)");
    $stmt->execute([$movie_id, $screen_id, $show_date, $show_time, $price_regular, $price_premium, $price_recliner]);
    flash('success', 'Show added.');
    redirect('shows.php');
}

$movies = $pdo->query("SELECT * FROM movies ORDER BY title")->fetchAll();
$screens = $pdo->query("SELECT sc.*, t.name AS theater_name FROM screens sc JOIN theaters t ON sc.theater_id = t.id ORDER BY t.name, sc.name")->fetchAll();

$shows = $pdo->query("
    SELECT sh.*, m.title, sc.name AS screen_name, t.name AS theater_name
    FROM shows sh
    JOIN movies m ON sh.movie_id = m.id
    JOIN screens sc ON sh.screen_id = sc.id
    JOIN theaters t ON sc.theater_id = t.id
    ORDER BY sh.show_date DESC, sh.show_time DESC
")->fetchAll();

require_once __DIR__ . '/../includes/header.php';
?>

<div class="admin-nav">
    <a href="index.php">Dashboard</a>
    <a href="movies.php">Movies</a>
    <a href="theaters.php">Theaters</a>
    <a href="shows.php" class="active">Shows</a>
    <a href="bookings.php">Bookings</a>
    <a href="fetch_posters.php">Fetch Posters</a>
</div>

<div class="form-card" style="max-width:100%;">
    <h2>Add Showtime</h2>
    <form method="POST">
        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:16px;">
            <div class="form-group">
                <label>Movie</label>
                <select name="movie_id" required>
                    <?php foreach ($movies as $m): ?>
                        <option value="<?= $m['id'] ?>"><?= e($m['title']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label>Theater / Screen</label>
                <select name="screen_id" required>
                    <?php foreach ($screens as $s): ?>
                        <option value="<?= $s['id'] ?>"><?= e($s['theater_name']) ?> — <?= e($s['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group"><label>Date</label><input type="date" name="show_date" required></div>
            <div class="form-group"><label>Time</label><input type="time" name="show_time" required></div>
            <div class="form-group"><label>Regular Price</label><input type="number" step="0.01" name="price_regular" value="150" required></div>
            <div class="form-group"><label>Premium Price</label><input type="number" step="0.01" name="price_premium" value="250" required></div>
            <div class="form-group"><label>Recliner Price</label><input type="number" step="0.01" name="price_recliner" value="400" required></div>
        </div>
        <button type="submit" class="btn">Add Show</button>
    </form>
</div>

<div class="section-title"><span>All Shows</span></div>
<table>
    <tr><th>Movie</th><th>Theater</th><th>Screen</th><th>Date</th><th>Time</th><th>Actions</th></tr>
    <?php foreach ($shows as $s): ?>
    <tr>
        <td><?= e($s['title']) ?></td>
        <td><?= e($s['theater_name']) ?></td>
        <td><?= e($s['screen_name']) ?></td>
        <td><?= format_show_date($s['show_date']) ?></td>
        <td><?= format_show_time($s['show_time']) ?></td>
        <td><a href="?delete=<?= $s['id'] ?>" style="color:#d2232a;" onclick="return confirm('Delete this show?')">Delete</a></td>
    </tr>
    <?php endforeach; ?>
</table>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
