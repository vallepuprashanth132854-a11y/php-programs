<?php
$base = '';
$page_title = 'Payment';
require_once __DIR__ . '/includes/bootstrap.php';

require_login();

if (empty($_SESSION['pending_booking'])) {
    redirect('index.php');
}
$pending = $_SESSION['pending_booking'];

$stmt = $pdo->prepare("
    SELECT s.*, m.title, t.name AS theater_name
    FROM shows s
    JOIN movies m ON s.movie_id = m.id
    JOIN screens sc ON s.screen_id = sc.id
    JOIN theaters t ON sc.theater_id = t.id
    WHERE s.id = ?
");
$stmt->execute([$pending['show_id']]);
$show = $stmt->fetch();

require_once __DIR__ . '/includes/header.php';
?>

<div class="section-title"><span>Confirm &amp; Pay</span></div>

<div style="display:flex; gap:24px; flex-wrap:wrap;">
    <div style="flex:1; min-width:260px;" class="theater-block">
        <h3><?= e($show['title']) ?></h3>
        <p style="color:#757575; margin:6px 0 14px;">
            <?= e($show['theater_name']) ?> · <?= format_show_date($show['show_date']) ?> · <?= format_show_time($show['show_time']) ?>
        </p>
        <?php foreach ($pending['seats'] as $s): ?>
            <div class="ticket-row">
                <span><?= e($s['label']) ?> (<?= ucfirst($s['type']) ?>)</span>
                <span><?= format_money($s['price']) ?></span>
            </div>
        <?php endforeach; ?>
        <div class="ticket-row" style="font-weight:700; border-bottom:none;">
            <span>Total Amount</span>
            <span><?= format_money($pending['total']) ?></span>
        </div>
    </div>

    <div style="flex:1; min-width:260px;" class="form-card" style="margin:0;">
        <h2>Payment Details</h2>
        <p style="font-size:12px; color:#757575; text-align:center; margin-bottom:14px;">
            🔒 This is a simulated payment for demo purposes. No real transaction occurs.
        </p>
        <form action="confirm.php" method="POST">
            <div class="form-group">
                <label>Payment Method</label>
                <select name="payment_method">
                    <option value="Credit/Debit Card">Credit / Debit Card</option>
                    <option value="UPI">UPI</option>
                    <option value="Net Banking">Net Banking</option>
                    <option value="Wallet">Wallet</option>
                </select>
            </div>
            <div class="form-group">
                <label>Card / UPI Number (demo only)</label>
                <input type="text" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" required>
            </div>
            <button type="submit" class="btn btn-block">Pay <?= format_money($pending['total']) ?></button>
        </form>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
