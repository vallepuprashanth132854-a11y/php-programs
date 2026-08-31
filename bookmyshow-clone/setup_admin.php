<?php
// ============================================================
// OPTIONAL RESET SCRIPT
// database.sql now seeds a working admin password already
// (admin@bms.com / admin123), so you do NOT need to run this
// after a fresh import. Keep this only as a fallback in case you
// ever need to reset the admin password back to the default.
//
// DELETE THIS FILE before deploying anywhere public — it is not
// secure to leave on a live server.
// ============================================================

require_once __DIR__ . '/config/db.php';

$password = 'admin123';
$hash = password_hash($password, PASSWORD_DEFAULT);

$stmt = $pdo->prepare("UPDATE users SET password = ? WHERE email = 'admin@bms.com'");
$stmt->execute([$hash]);

if ($stmt->rowCount() > 0) {
    echo "Admin password set successfully.<br>";
    echo "Login with: admin@bms.com / admin123<br><br>";
    echo "<strong>Please delete setup_admin.php now.</strong>";
} else {
    echo "No admin user found. Make sure you imported database.sql first.";
}
