<?php
$base = '../';
$page_title = 'All Bookings';
require_once __DIR__ . '/../includes/bootstrap.php';
require_admin();

if (isset($_GET['cancel'])) {
    $stmt = $pdo->prepare("UPDATE bookings SET status = 'cancelled' WHERE id = ?");
    $stmt->execute([(int)$_GET['cancel']]);
    flash('success', 'Booking cancelled.');
    redirect('bookings.php');
}

$bookings = $pdo->query("
    SELECT b.*, u.name AS user_name, u.email, m.title, sh.show_date, sh.show_time
    FROM bookings b
    JOIN users u ON b.user_id = u.id
    JOIN shows sh ON b.show_id = sh.id
    JOIN movies m ON sh.movie_id = m.id
    ORDER BY b.created_at DESC
")->fetchAll();

require_once __DIR__ . '/../includes/header.php';
?>

<div class="admin-nav">
    <a href="index.php">Dashboard</a>
    <a href="movies.php">Movies</a>
    <a href="theaters.php">Theaters</a>
    <a href="shows.php">Shows</a>
    <a href="bookings.php" class="active">Bookings</a>
    <a href="fetch_posters.php">Fetch Posters</a>
</div>

<div class="section-title"><span>All Bookings</span></div>
<table>
    <tr><th>Code</th><th>User</th><th>Movie</th><th>Show</th><th>Amount</th><th>Status</th><th>Actions</th></tr>
    <?php foreach ($bookings as $b): ?>
    <tr>
        <td><?= e($b['booking_code']) ?></td>
        <td><?= e($b['user_name']) ?><br><small style="color:#999;"><?= e($b['email']) ?></small></td>
        <td><?= e($b['title']) ?></td>
        <td><?= format_show_date($b['show_date']) ?>, <?= format_show_time($b['show_time']) ?></td>
        <td><?= format_money($b['total_amount']) ?></td>
        <td><span class="badge badge-<?= e($b['status']) ?>"><?= ucfirst(e($b['status'])) ?></span></td>
        <td>
            <?php if ($b['status'] === 'confirmed'): ?>
                <a href="?cancel=<?= $b['id'] ?>" style="color:#d2232a;" onclick="return confirm('Cancel this booking?')">Cancel</a>
            <?php else: ?>—<?php endif; ?>
        </td>
    </tr>
    <?php endforeach; ?>
    <?php if (empty($bookings)): ?>
    <tr><td colspan="7" style="text-align:center; color:#999;">No bookings yet.</td></tr>
    <?php endif; ?>
</table>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
