<?php
$base = '../';
$page_title = 'Manage Theaters';
require_once __DIR__ . '/../includes/bootstrap.php';
require_admin();

if (isset($_GET['delete_theater'])) {
    $stmt = $pdo->prepare("DELETE FROM theaters WHERE id = ?");
    $stmt->execute([(int)$_GET['delete_theater']]);
    flash('success', 'Theater deleted.');
    redirect('theaters.php');
}

if (isset($_GET['delete_screen'])) {
    $stmt = $pdo->prepare("DELETE FROM screens WHERE id = ?");
    $stmt->execute([(int)$_GET['delete_screen']]);
    flash('success', 'Screen deleted.');
    redirect('theaters.php');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($_POST['form_type'] === 'theater') {
        $name = trim($_POST['name'] ?? '');
        $city = trim($_POST['city'] ?? '');
        $address = trim($_POST['address'] ?? '');
        if ($name && $city) {
            $stmt = $pdo->prepare("INSERT INTO theaters (name, city, address) VALUES (?,?,?)");
            $stmt->execute([$name, $city, $address]);
            flash('success', 'Theater added.');
        }
    } elseif ($_POST['form_type'] === 'screen') {
        $theater_id = (int)$_POST['theater_id'];
        $name = trim($_POST['screen_name'] ?? '');
        $rows = (int)$_POST['rows_count'];
        $cols = (int)$_POST['cols_count'];
        if ($theater_id && $name) {
            $stmt = $pdo->prepare("INSERT INTO screens (theater_id, name, rows_count, cols_count) VALUES (?,?,?,?)");
            $stmt->execute([$theater_id, $name, $rows, $cols]);
            flash('success', 'Screen added.');
        }
    }
    redirect('theaters.php');
}

$theaters = $pdo->query("SELECT * FROM theaters ORDER BY city, name")->fetchAll();
$screens = $pdo->query("
    SELECT sc.*, t.name AS theater_name FROM screens sc JOIN theaters t ON sc.theater_id = t.id ORDER BY t.name, sc.name
")->fetchAll();

require_once __DIR__ . '/../includes/header.php';
?>

<div class="admin-nav">
    <a href="index.php">Dashboard</a>
    <a href="movies.php">Movies</a>
    <a href="theaters.php" class="active">Theaters</a>
    <a href="shows.php">Shows</a>
    <a href="bookings.php">Bookings</a>
    <a href="fetch_posters.php">Fetch Posters</a>
</div>

<div style="display:flex; gap:20px; flex-wrap:wrap;">
    <div class="form-card" style="margin:0; flex:1; min-width:280px;">
        <h2>Add Theater</h2>
        <form method="POST">
            <input type="hidden" name="form_type" value="theater">
            <div class="form-group"><label>Name</label><input type="text" name="name" required></div>
            <div class="form-group"><label>City</label><input type="text" name="city" required></div>
            <div class="form-group"><label>Address</label><input type="text" name="address"></div>
            <button type="submit" class="btn btn-block">Add Theater</button>
        </form>
    </div>

    <div class="form-card" style="margin:0; flex:1; min-width:280px;">
        <h2>Add Screen</h2>
        <form method="POST">
            <input type="hidden" name="form_type" value="screen">
            <div class="form-group">
                <label>Theater</label>
                <select name="theater_id" required>
                    <?php foreach ($theaters as $t): ?>
                        <option value="<?= $t['id'] ?>"><?= e($t['name']) ?> (<?= e($t['city']) ?>)</option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group"><label>Screen Name</label><input type="text" name="screen_name" placeholder="Screen 1" required></div>
            <div class="form-group"><label>Rows</label><input type="number" name="rows_count" value="8" min="1" max="26" required></div>
            <div class="form-group"><label>Seats per Row</label><input type="number" name="cols_count" value="10" min="1" max="30" required></div>
            <button type="submit" class="btn btn-block">Add Screen</button>
        </form>
    </div>
</div>

<div class="section-title"><span>Theaters</span></div>
<table>
    <tr><th>Name</th><th>City</th><th>Address</th><th>Actions</th></tr>
    <?php foreach ($theaters as $t): ?>
    <tr>
        <td><?= e($t['name']) ?></td>
        <td><?= e($t['city']) ?></td>
        <td><?= e($t['address']) ?></td>
        <td><a href="?delete_theater=<?= $t['id'] ?>" style="color:#d2232a;" onclick="return confirm('Delete this theater and all its screens/shows?')">Delete</a></td>
    </tr>
    <?php endforeach; ?>
</table>

<div class="section-title"><span>Screens</span></div>
<table>
    <tr><th>Theater</th><th>Screen</th><th>Rows x Seats</th><th>Actions</th></tr>
    <?php foreach ($screens as $s): ?>
    <tr>
        <td><?= e($s['theater_name']) ?></td>
        <td><?= e($s['name']) ?></td>
        <td><?= $s['rows_count'] ?> x <?= $s['cols_count'] ?></td>
        <td><a href="?delete_screen=<?= $s['id'] ?>" style="color:#d2232a;" onclick="return confirm('Delete this screen and its shows?')">Delete</a></td>
    </tr>
    <?php endforeach; ?>
</table>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
