<?php
// Setup (db, functions, session/city) now lives in bootstrap.php so it can
// be required early — before any redirects — without producing output.
// Pages should require bootstrap.php at the top and only require this
// header.php once they're ready to actually render the page.
require_once __DIR__ . '/bootstrap.php';
$b = isset($base) ? $base : '';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= isset($page_title) ? e($page_title) . ' - ShowTime' : 'ShowTime - Book Movie Tickets' ?></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?= $b ?>assets/css/style.css">
</head>
<body>
<script>window.SHOWTIME_BASE = <?= json_encode($b) ?>;</script>

<header class="navbar">
    <div class="navbar-inner">
        <a href="<?= $b ?>index.php" class="logo">Show<span>Time</span></a>

        <form class="nav-search" action="<?= $b ?>index.php" method="GET">
            <svg class="search-icon" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" name="search" placeholder="Search for movies..." value="<?= e($_GET['search'] ?? '') ?>">
            <button type="submit">Go</button>
        </form>

        <button type="button" class="nav-city" id="cityTrigger">
            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 0 1 18 0Z"/><circle cx="12" cy="10" r="3"/></svg>
            <span id="cityTriggerLabel"><?= e($current_city) ?></span>
            <svg class="chev" viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
        </button>

        <nav class="nav-links">
            <?php if (is_logged_in()): ?>
                <?php if (is_admin()): ?>
                    <a href="<?= $b ?>admin/index.php">Admin</a>
                <?php endif; ?>
                <a href="<?= $b ?>my_bookings.php">My Bookings</a>
                <span class="nav-user">Hi, <?= e($_SESSION['user_name']) ?></span>
                <a href="<?= $b ?>logout.php" class="btn-outline">Logout</a>
            <?php else: ?>
                <a href="<?= $b ?>login.php" class="btn-outline">Sign In</a>
            <?php endif; ?>
        </nav>
    </div>
</header>

<!-- City selector modal -->
<div class="city-modal-overlay" id="cityModalOverlay">
    <div class="city-modal">
        <div class="city-modal-head">
            <h3>Select your city</h3>
            <button type="button" class="city-modal-close" id="cityModalClose" aria-label="Close">&times;</button>
        </div>
        <div class="city-modal-search">
            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" id="citySearchInput" placeholder="Search for your city">
        </div>
        <div class="city-modal-body">
            <div class="city-group" id="popularCityGroup">
                <p class="city-group-title">Popular Cities</p>
                <div class="city-chip-grid">
                    <?php foreach ($cities['popular'] as $c): ?>
                        <button type="button" class="city-chip <?= $c === $current_city ? 'active' : '' ?>" data-city="<?= e($c) ?>"><?= e($c) ?></button>
                    <?php endforeach; ?>
                </div>
            </div>
            <div class="city-group" id="allCityGroup">
                <p class="city-group-title">All Cities</p>
                <div class="city-list-grid">
                    <?php foreach ($cities['all'] as $c): ?>
                        <button type="button" class="city-list-item <?= $c === $current_city ? 'active' : '' ?>" data-city="<?= e($c) ?>"><?= e($c) ?></button>
                    <?php endforeach; ?>
                </div>
            </div>
            <p class="city-no-results" id="cityNoResults" style="display:none;">No cities match your search.</p>
        </div>
    </div>
</div>

<main class="container">
<?php
$flash_success = flash('success');
$flash_error = flash('error');
?>
<?php if ($flash_success): ?>
    <div class="alert alert-success"><?= e($flash_success) ?></div>
<?php endif; ?>
<?php if ($flash_error): ?>
    <div class="alert alert-error"><?= e($flash_error) ?></div>
<?php endif; ?>
