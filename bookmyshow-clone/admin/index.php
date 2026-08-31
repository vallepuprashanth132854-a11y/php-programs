<?php
$base = '../';
$page_title = 'Admin Dashboard';
require_once __DIR__ . '/../includes/bootstrap.php';
require_admin();

$totalMovies = $pdo->query("SELECT COUNT(*) c FROM movies")->fetch()['c'];
$totalBookings = $pdo->query("SELECT COUNT(*) c FROM bookings WHERE status='confirmed'")->fetch()['c'];
$totalRevenue = $pdo->query("SELECT COALESCE(SUM(total_amount),0) s FROM bookings WHERE status='confirmed'")->fetch()['s'];
$totalUsers = $pdo->query("SELECT COUNT(*) c FROM users WHERE role='user'")->fetch()['c'];

$recentBookings = $pdo->query("
    SELECT b.booking_code, b.total_amount, b.status, b.created_at, u.name AS user_name, m.title
    FROM bookings b
    JOIN users u ON b.user_id = u.id
    JOIN shows sh ON b.show_id = sh.id
    JOIN movies m ON sh.movie_id = m.id
    ORDER BY b.created_at DESC LIMIT 10
")->fetchAll();

require_once __DIR__ . '/../includes/header.php';
?>

<div class="admin-nav">
    <a href="index.php" class="active">Dashboard</a>
    <a href="movies.php">Movies</a>
    <a href="theaters.php">Theaters</a>
    <a href="shows.php">Shows</a>
    <a href="bookings.php">Bookings</a>
    <a href="fetch_posters.php">Fetch Posters</a>
</div>

<div class="stat-cards">
    <div class="stat-card"><div class="num"><?= $totalMovies ?></div><div class="label">Total Movies</div></div>
    <div class="stat-card"><div class="num"><?= $totalBookings ?></div><div class="label">Confirmed Bookings</div></div>
    <div class="stat-card"><div class="num"><?= format_money($totalRevenue) ?></div><div class="label">Total Revenue</div></div>
    <div class="stat-card"><div class="num"><?= $totalUsers ?></div><div class="label">Registered Users</div></div>
</div>

<div class="section-title"><span>Recent Bookings</span></div>
<table>
    <tr><th>Code</th><th>User</th><th>Movie</th><th>Amount</th><th>Status</th><th>Date</th></tr>
    <?php foreach ($recentBookings as $b): ?>
    <tr>
        <td><?= e($b['booking_code']) ?></td>
        <td><?= e($b['user_name']) ?></td>
        <td><?= e($b['title']) ?></td>
        <td><?= format_money($b['total_amount']) ?></td>
        <td><span class="badge badge-<?= e($b['status']) ?>"><?= ucfirst(e($b['status'])) ?></span></td>
        <td><?= date('d M Y, g:i A', strtotime($b['created_at'])) ?></td>
    </tr>
    <?php endforeach; ?>
    <?php if (empty($recentBookings)): ?>
    <tr><td colspan="6" style="text-align:center; color:#999;">No bookings yet.</td></tr>
    <?php endif; ?>
</table>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
