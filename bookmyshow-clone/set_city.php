<?php
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/functions.php';

$cities = require __DIR__ . '/config/cities.php';
$allCities = $cities['all'];

$city = trim($_GET['city'] ?? $_POST['city'] ?? '');

if ($city !== '' && in_array($city, $allCities, true)) {
    $_SESSION['city'] = $city;
}

$back = $_SERVER['HTTP_REFERER'] ?? 'index.php';
// Only allow redirecting back to a local page, never an external URL
if (!preg_match('#^https?://#i', $back) || strpos($back, ($_SERVER['HTTP_HOST'] ?? '')) !== false) {
    redirect($back);
} else {
    redirect('index.php');
}
