<?php
$base = '';
$page_title = 'My Bookings';
require_once __DIR__ . '/includes/bootstrap.php';

require_login();

$stmt = $pdo->prepare("
    SELECT b.*, m.title, sh.show_date, sh.show_time, t.name AS theater_name
    FROM bookings b
    JOIN shows sh ON b.show_id = sh.id
    JOIN movies m ON sh.movie_id = m.id
    JOIN screens sc ON sh.screen_id = sc.id
    JOIN theaters t ON sc.theater_id = t.id
    WHERE b.user_id = ?
    ORDER BY b.created_at DESC
");
$stmt->execute([$_SESSION['user_id']]);
$bookings = $stmt->fetchAll();

require_once __DIR__ . '/includes/header.php';
?>

<div class="section-title"><span>My Bookings</span></div>

<?php if (empty($bookings)): ?>
    <p style="color:#757575;">You haven't booked any tickets yet. <a href="index.php" style="color:#d2232a;">Browse movies</a></p>
<?php else: ?>
    <?php foreach ($bookings as $b): ?>
        <div class="theater-block">
            <div style="display:flex; justify-content:space-between; flex-wrap:wrap; gap:10px;">
                <div>
                    <h3><?= e($b['title']) ?></h3>
                    <p style="color:#757575; font-size:13px; margin-top:4px;">
                        <?= e($b['theater_name']) ?> · <?= format_show_date($b['show_date']) ?> · <?= format_show_time($b['show_time']) ?>
                    </p>
                    <p style="font-size:13px; margin-top:6px;">Booking Code: <strong><?= e($b['booking_code']) ?></strong></p>
                </div>
                <div style="text-align:right;">
                    <span class="badge badge-<?= e($b['status']) ?>"><?= ucfirst(e($b['status'])) ?></span>
                    <p style="margin-top:8px; font-weight:700;"><?= format_money($b['total_amount']) ?></p>
                    <?php if ($b['status'] === 'confirmed'): ?>
                        <a href="booking_success.php?code=<?= urlencode($b['booking_code']) ?>" style="color:#d2232a; font-size:13px; font-weight:600;">View Ticket</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    <?php endforeach; ?>
<?php endif; ?>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
