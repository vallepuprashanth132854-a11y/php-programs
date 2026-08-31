<?php
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/functions.php';

require_login();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('index.php');
}

$show_id = (int)($_POST['show_id'] ?? 0);
$seat_ids = array_filter(array_map('intval', explode(',', $_POST['seat_ids'] ?? '')));

if ($show_id <= 0 || empty($seat_ids)) {
    flash('error', 'Please select at least one seat.');
    redirect('seats.php?show_id=' . $show_id);
}

// Fetch show + pricing
$stmt = $pdo->prepare("
    SELECT s.*, m.title FROM shows s JOIN movies m ON s.movie_id = m.id WHERE s.id = ?
");
$stmt->execute([$show_id]);
$show = $stmt->fetch();

if (!$show) {
    flash('error', 'Show not found.');
    redirect('index.php');
}

// Verify none of the selected seats are already booked
$placeholders = implode(',', array_fill(0, count($seat_ids), '?'));
$stmt = $pdo->prepare("
    SELECT bs.seat_id FROM booking_seats bs
    JOIN bookings b ON bs.booking_id = b.id
    WHERE bs.show_id = ? AND b.status != 'cancelled' AND bs.seat_id IN ($placeholders)
");
$stmt->execute(array_merge([$show_id], $seat_ids));
$alreadyBooked = $stmt->fetchAll();

if (!empty($alreadyBooked)) {
    flash('error', 'Sorry, one or more selected seats were just booked by someone else. Please choose again.');
    redirect('seats.php?show_id=' . $show_id);
}

// Fetch seat details for pricing
$stmt = $pdo->prepare("SELECT * FROM seats WHERE id IN ($placeholders)");
$stmt->execute($seat_ids);
$seatRows = $stmt->fetchAll();

$prices = [
    'regular'  => (float)$show['price_regular'],
    'premium'  => (float)$show['price_premium'],
    'recliner' => (float)$show['price_recliner'],
];

$selection = [];
$total = 0;
foreach ($seatRows as $s) {
    $price = $prices[$s['seat_type']];
    $total += $price;
    $selection[] = [
        'seat_id' => $s['id'],
        'label'   => $s['seat_row'] . $s['seat_number'],
        'type'    => $s['seat_type'],
        'price'   => $price,
    ];
}

$_SESSION['pending_booking'] = [
    'show_id' => $show_id,
    'seats'   => $selection,
    'total'   => $total,
];

redirect('payment.php');
