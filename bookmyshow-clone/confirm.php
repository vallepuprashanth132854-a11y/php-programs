<?php
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/functions.php';

require_login();

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || empty($_SESSION['pending_booking'])) {
    redirect('index.php');
}

$pending = $_SESSION['pending_booking'];
$payment_method = $_POST['payment_method'] ?? 'Card';
$show_id = $pending['show_id'];
$seat_ids = array_column($pending['seats'], 'seat_id');

try {
    $pdo->beginTransaction();

    // Re-check seat availability inside the transaction to prevent race conditions
    $placeholders = implode(',', array_fill(0, count($seat_ids), '?'));
    $stmt = $pdo->prepare("
        SELECT bs.seat_id FROM booking_seats bs
        JOIN bookings b ON bs.booking_id = b.id
        WHERE bs.show_id = ? AND b.status != 'cancelled' AND bs.seat_id IN ($placeholders)
        FOR UPDATE
    ");
    $stmt->execute(array_merge([$show_id], $seat_ids));
    if ($stmt->fetch()) {
        $pdo->rollBack();
        flash('error', 'Sorry, one or more seats were just booked by someone else.');
        unset($_SESSION['pending_booking']);
        redirect('seats.php?show_id=' . $show_id);
    }

    $bookingCode = generate_booking_code();
    $stmt = $pdo->prepare("
        INSERT INTO bookings (user_id, show_id, booking_code, total_amount, status, payment_method)
        VALUES (?, ?, ?, ?, 'confirmed', ?)
    ");
    $stmt->execute([$_SESSION['user_id'], $show_id, $bookingCode, $pending['total'], $payment_method]);
    $bookingId = $pdo->lastInsertId();

    $stmt = $pdo->prepare("INSERT INTO booking_seats (booking_id, seat_id, show_id, price) VALUES (?, ?, ?, ?)");
    foreach ($pending['seats'] as $s) {
        $stmt->execute([$bookingId, $s['seat_id'], $show_id, $s['price']]);
    }

    $pdo->commit();
    unset($_SESSION['pending_booking']);
    redirect('booking_success.php?code=' . urlencode($bookingCode));

} catch (PDOException $e) {
    $pdo->rollBack();
    // Duplicate seat entry (unique_seat_per_show) means someone booked the seat first
    if ($e->getCode() == 23000) {
        flash('error', 'Sorry, one or more seats were just booked by someone else.');
        unset($_SESSION['pending_booking']);
        redirect('seats.php?show_id=' . $show_id);
    }
    flash('error', 'Something went wrong while confirming your booking. Please try again.');
    redirect('payment.php');
} catch (Exception $e) {
    $pdo->rollBack();
    flash('error', 'Something went wrong while confirming your booking. Please try again.');
    redirect('payment.php');
}
