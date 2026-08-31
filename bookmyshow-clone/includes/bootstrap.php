<?php
// ============================================================
// App bootstrap: DB connection, helper functions, session/city
// setup. This file produces NO output, so it is always safe to
// require at the very top of a page — before any header('Location: ..')
// redirects (login checks, admin checks, form-handling redirects,
// etc.) that must run before any HTML has been sent.
// ============================================================
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/functions.php';

$cities = require __DIR__ . '/../config/cities.php';
$current_city = $_SESSION['city'] ?? 'Mumbai';
