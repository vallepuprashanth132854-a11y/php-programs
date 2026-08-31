<?php
$base = '';
$page_title = 'Select Seats';
require_once __DIR__ . '/includes/bootstrap.php';

require_login();

$show_id = (int)($_GET['show_id'] ?? 0);

$stmt = $pdo->prepare("
    SELECT s.*, m.title, m.duration_mins, sc.id AS screen_id, sc.name AS screen_name,
           sc.rows_count, sc.cols_count, t.name AS theater_name, t.address
    FROM shows s
    JOIN movies m ON s.movie_id = m.id
    JOIN screens sc ON s.screen_id = sc.id
    JOIN theaters t ON sc.theater_id = t.id
    WHERE s.id = ?
");
$stmt->execute([$show_id]);
$show = $stmt->fetch();

if (!$show) {
    flash('error', 'Show not found.');
    redirect('index.php');
}

// Lazily generate seats for this screen if they don't exist yet
$count = $pdo->prepare("SELECT COUNT(*) c FROM seats WHERE screen_id = ?");
$count->execute([$show['screen_id']]);
if ($count->fetch()['c'] == 0) {
    $rows = $show['rows_count'];
    $cols = $show['cols_count'];
    $insert = $pdo->prepare("INSERT INTO seats (screen_id, seat_row, seat_number, seat_type) VALUES (?,?,?,?)");
    for ($r = 0; $r < $rows; $r++) {
        $rowLetter = chr(65 + $r); // A, B, C...
        if ($r >= $rows - 2) {
            $type = 'recliner';
        } elseif ($r >= 2) {
            $type = 'premium';
        } else {
            $type = 'regular';
        }
        for ($c = 1; $c <= $cols; $c++) {
            $insert->execute([$show['screen_id'], $rowLetter, $c, $type]);
        }
    }
}

// Fetch all seats for this screen
$stmt = $pdo->prepare("SELECT * FROM seats WHERE screen_id = ? ORDER BY seat_row, seat_number");
$stmt->execute([$show['screen_id']]);
$seats = $stmt->fetchAll();

// Fetch already booked seat ids for this show (only from confirmed/pending bookings)
$stmt = $pdo->prepare("
    SELECT bs.seat_id FROM booking_seats bs
    JOIN bookings b ON bs.booking_id = b.id
    WHERE bs.show_id = ? AND b.status != 'cancelled'
");
$stmt->execute([$show_id]);
$booked_ids = array_column($stmt->fetchAll(), 'seat_id');

// Group seats by row
$rows_map = [];
foreach ($seats as $s) {
    $rows_map[$s['seat_row']][] = $s;
}

$prices = [
    'regular'  => (float)$show['price_regular'],
    'premium'  => (float)$show['price_premium'],
    'recliner' => (float)$show['price_recliner'],
];

require_once __DIR__ . '/includes/header.php';
?>

<div class="section-title">
    <span><?= e($show['title']) ?> — <?= e($show['theater_name']) ?></span>
</div>
<p style="color:#757575; margin-bottom:16px;">
    <?= format_show_date($show['show_date']) ?> · <?= format_show_time($show['show_time']) ?> · <?= e($show['screen_name']) ?>
</p>

<div class="seat-page">
    <div class="seat-legend">
        <div class="legend-item"><span class="legend-box" style="border:1px solid #999;"></span> Regular (<?= format_money($prices['regular']) ?>)</div>
        <div class="legend-item"><span class="legend-box" style="border:1px solid #7b1fa2;"></span> Premium (<?= format_money($prices['premium']) ?>)</div>
        <div class="legend-item"><span class="legend-box" style="border:1px solid #ef6c00;"></span> Recliner (<?= format_money($prices['recliner']) ?>)</div>
        <div class="legend-item"><span class="legend-box" style="background:#2e7d32;"></span> Selected</div>
        <div class="legend-item"><span class="legend-box" style="background:#ccc;"></span> Booked</div>
    </div>

    <div class="seat-map" id="seatMap">
        <?php foreach ($rows_map as $rowLetter => $rowSeats): ?>
            <div class="seat-row">
                <div class="row-label"><?= e($rowLetter) ?></div>
                <?php foreach ($rowSeats as $s):
                    $isBooked = in_array($s['id'], $booked_ids);
                    $classes = 'seat ' . $s['seat_type'] . ($isBooked ? ' booked' : '');
                ?>
                    <div class="<?= $classes ?>"
                         data-id="<?= $s['id'] ?>"
                         data-type="<?= $s['seat_type'] ?>"
                         data-price="<?= $prices[$s['seat_type']] ?>"
                         data-label="<?= e($rowLetter . $s['seat_number']) ?>"
                         <?= $isBooked ? '' : 'onclick="toggleSeat(this)"' ?>>
                        <?= (int)$s['seat_number'] ?>
                    </div>
                <?php endforeach; ?>
                <div class="row-label"><?= e($rowLetter) ?></div>
            </div>
        <?php endforeach; ?>
    </div>

    <div class="screen-curve"></div>
    <div class="screen-info">All eyes this way please — SCREEN</div>

    <form action="book.php" method="POST" id="bookingForm">
        <input type="hidden" name="show_id" value="<?= $show_id ?>">
        <input type="hidden" name="seat_ids" id="seatIdsInput" value="">
        <div class="booking-summary">
            <div>
                <div id="selectedCount">0 seats selected</div>
                <div id="selectedSeats" style="font-size:12px; color:#ccc;"></div>
            </div>
            <div style="font-size:20px; font-weight:700;" id="totalAmount"><?= format_money(0) ?></div>
            <button type="submit" class="btn" id="proceedBtn" disabled>Proceed to Pay</button>
        </div>
    </form>
</div>

<script>
let selected = new Set();

function toggleSeat(el) {
    const id = el.dataset.id;
    if (selected.has(id)) {
        selected.delete(id);
        el.classList.remove('selected');
    } else {
        if (selected.size >= 10) {
            alert('You can select up to 10 seats at a time.');
            return;
        }
        selected.add(id);
        el.classList.add('selected');
    }
    updateSummary();
}

function updateSummary() {
    const seatEls = document.querySelectorAll('.seat.selected');
    let total = 0;
    let labels = [];
    seatEls.forEach(el => {
        total += parseFloat(el.dataset.price);
        labels.push(el.dataset.label);
    });
    document.getElementById('selectedCount').textContent = selected.size + ' seat(s) selected';
    document.getElementById('selectedSeats').textContent = labels.join(', ');
    document.getElementById('totalAmount').textContent = '₹' + total.toFixed(2);
    document.getElementById('seatIdsInput').value = Array.from(selected).join(',');
    document.getElementById('proceedBtn').disabled = selected.size === 0;
}
</script>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
