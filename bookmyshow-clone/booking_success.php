<?php
$base = '';
$page_title = 'Booking Confirmed';
require_once __DIR__ . '/includes/bootstrap.php';

require_login();

$code = $_GET['code'] ?? '';

$stmt = $pdo->prepare("
    SELECT b.*, m.title, m.duration_mins, t.name AS theater_name, t.address, sh.show_date, sh.show_time, sc.name AS screen_name
    FROM bookings b
    JOIN shows sh ON b.show_id = sh.id
    JOIN movies m ON sh.movie_id = m.id
    JOIN screens sc ON sh.screen_id = sc.id
    JOIN theaters t ON sc.theater_id = t.id
    WHERE b.booking_code = ? AND b.user_id = ?
");
$stmt->execute([$code, $_SESSION['user_id']]);
$booking = $stmt->fetch();

if (!$booking) {
    flash('error', 'Booking not found.');
    redirect('my_bookings.php');
}

$stmt = $pdo->prepare("SELECT s.seat_row, s.seat_number, s.seat_type FROM booking_seats bs JOIN seats s ON bs.seat_id = s.id WHERE bs.booking_id = ?");
$stmt->execute([$booking['id']]);
$seats = $stmt->fetchAll();
$seatLabels = array_map(fn($s) => $s['seat_row'] . $s['seat_number'], $seats);

require_once __DIR__ . '/includes/header.php';
?>

<div class="ticket-card">
    <div class="ticket-header">
        <div style="font-size:40px;">✓</div>
        <h2>Booking Confirmed!</h2>
        <p>Your tickets are booked successfully.</p>
    </div>
    <div class="ticket-body">
        <div class="ticket-code"><?= e($booking['booking_code']) ?></div>
        <div class="ticket-row"><span>Movie</span><span><?= e($booking['title']) ?></span></div>
        <div class="ticket-row"><span>Theater</span><span><?= e($booking['theater_name']) ?></span></div>
        <div class="ticket-row"><span>Screen</span><span><?= e($booking['screen_name']) ?></span></div>
        <div class="ticket-row"><span>Date</span><span><?= format_show_date($booking['show_date']) ?></span></div>
        <div class="ticket-row"><span>Time</span><span><?= format_show_time($booking['show_time']) ?></span></div>
        <div class="ticket-row"><span>Seats</span><span><?= e(implode(', ', $seatLabels)) ?></span></div>
        <div class="ticket-row"><span>Payment</span><span><?= e($booking['payment_method']) ?></span></div>
        <div class="ticket-row" style="font-weight:700; border-bottom:none;">
            <span>Total Paid</span><span><?= format_money($booking['total_amount']) ?></span>
        </div>
        <a href="my_bookings.php" class="btn btn-block" style="margin-top:16px; text-align:center;">View My Bookings</a>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
