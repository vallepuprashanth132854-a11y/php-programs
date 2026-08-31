<?php
// ============================================================
// Shared helper functions
// ============================================================

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function is_logged_in(): bool {
    return isset($_SESSION['user_id']);
}

function is_admin(): bool {
    return is_logged_in() && ($_SESSION['role'] ?? '') === 'admin';
}

function require_login(): void {
    if (!is_logged_in()) {
        header('Location: login.php');
        exit;
    }
}

function require_admin(): void {
    if (!is_admin()) {
        header('Location: ../login.php');
        exit;
    }
}

function e(?string $str): string {
    return htmlspecialchars($str ?? '', ENT_QUOTES, 'UTF-8');
}

function redirect(string $path): void {
    header("Location: $path");
    exit;
}

function generate_booking_code(): string {
    return 'BMS' . strtoupper(substr(uniqid(), -8));
}

function flash(string $key, ?string $message = null) {
    if ($message !== null) {
        $_SESSION['flash'][$key] = $message;
        return;
    }
    if (!empty($_SESSION['flash'][$key])) {
        $msg = $_SESSION['flash'][$key];
        unset($_SESSION['flash'][$key]);
        return $msg;
    }
    return null;
}

function format_money($amount): string {
    return '₹' . number_format((float)$amount, 2);
}

function format_show_time(string $time): string {
    return date('g:i A', strtotime($time));
}

function format_show_date(string $date): string {
    return date('D, d M Y', strtotime($date));
}

// Deterministic gradient per movie id so posters without real artwork
// still look distinct instead of identical grey boxes.
function poster_gradient(int $id): string {
    $palettes = [
        ['#ff5f6d', '#ffc371'], ['#7f00ff', '#e100ff'], ['#00c6ff', '#0072ff'],
        ['#f857a6', '#ff5858'], ['#11998e', '#38ef7d'], ['#fc4a1a', '#f7b733'],
        ['#4568dc', '#b06ab3'], ['#134e5e', '#71b280'],
    ];
    $p = $palettes[$id % count($palettes)];
    return "linear-gradient(145deg, {$p[0]}, {$p[1]})";
}

// Resolve a poster's CSS background: a real uploaded/linked image if one
// exists, otherwise a fallback gradient. Used by the homepage, movie
// detail page, and admin movie list so uploaded posters show everywhere.
function poster_background(array $m): array {
    $path = trim($m['poster_url'] ?? '');
    $isRemote = (bool)preg_match('#^https?://#i', $path);
    $localFile = __DIR__ . '/../' . ltrim($path, '/');

    if ($path !== '' && ($isRemote || (strpos($path, '..') === false && file_exists($localFile)))) {
        $safeUrl = str_replace(["'", '"'], '', $path);
        return [
            'style'     => "background-image:url('" . $safeUrl . "'); background-size:cover; background-position:center;",
            'has_image' => true,
        ];
    }

    return [
        'style'     => 'background:' . poster_gradient((int)($m['id'] ?? 0)) . ';',
        'has_image' => false,
    ];
}

// Absolute path helper for admin upload handling (movies live under posters/)
function poster_upload_dir(): string {
    return __DIR__ . '/../assets/images/posters/';
}
