<?php
$base = '';
require_once __DIR__ . '/includes/bootstrap.php';

$movie_id = (int)($_GET['id'] ?? 0);
$stmt = $pdo->prepare("SELECT * FROM movies WHERE id = ?");
$stmt->execute([$movie_id]);
$movie = $stmt->fetch();

if (!$movie) {
    flash('error', 'Movie not found.');
    redirect('index.php');
}
$page_title = $movie['title'];

// Fetch shows for this movie (today onward), grouped by theater.
// Theaters in the currently selected city are shown first.
$city = $_SESSION['city'] ?? 'Mumbai';
$stmt = $pdo->prepare("
    SELECT s.id AS show_id, s.show_date, s.show_time,
           sc.name AS screen_name, t.id AS theater_id, t.name AS theater_name, t.address, t.city
    FROM shows s
    JOIN screens sc ON s.screen_id = sc.id
    JOIN theaters t ON sc.theater_id = t.id
    WHERE s.movie_id = ? AND s.show_date >= CURDATE()
    ORDER BY (t.city = ?) DESC, t.name, s.show_date, s.show_time
");
$stmt->execute([$movie_id, $city]);
$shows = $stmt->fetchAll();

// Group by date, then by theater
$grouped = [];
foreach ($shows as $s) {
    $grouped[$s['show_date']][$s['theater_id']]['theater'] = $s;
    $grouped[$s['show_date']][$s['theater_id']]['shows'][] = $s;
}

require_once __DIR__ . '/includes/header.php';
?>

<div class="movie-detail">
    <div class="movie-poster" style="height:340px; <?= poster_background($movie)['style'] ?>">
        <?php if (!poster_background($movie)['has_image']): ?>
            <span class="poster-title"><?= e($movie['title']) ?></span>
        <?php endif; ?>
    </div>
    <div class="movie-detail-info">
        <h1><?= e($movie['title']) ?></h1>
        <?php if ((float)$movie['rating'] > 0): ?>
            <div class="rating-badge">★ <?= e($movie['rating']) ?>/10</div>
        <?php endif; ?>
        <div class="movie-meta">
            <span><?= e($movie['genre']) ?></span>
            <span><?= e($movie['language']) ?></span>
            <span><?= (int)$movie['duration_mins'] ?> mins</span>
            <span>Release: <?= date('d M Y', strtotime($movie['release_date'])) ?></span>
        </div>
        <p><?= nl2br(e($movie['description'])) ?></p>
    </div>
</div>

<div class="section-title"><span>Showtimes</span></div>

<?php if (empty($grouped)): ?>
    <p style="color:#8b93a6;">No showtimes available currently.</p>
<?php else: ?>
    <?php foreach ($grouped as $date => $theaters): ?>
        <h3 class="showdate-heading"><?= format_show_date($date) ?></h3>
        <?php foreach ($theaters as $t): ?>
            <div class="theater-block <?= $t['theater']['city'] === $city ? '' : 'theater-other-city' ?>">
                <div class="theater-block-head">
                    <div>
                        <h3><?= e($t['theater']['theater_name']) ?></h3>
                        <div class="addr"><?= e($t['theater']['address']) ?></div>
                    </div>
                    <span class="theater-city-tag"><?= e($t['theater']['city']) ?></span>
                </div>
                <div class="showtime-list">
                    <?php foreach ($t['shows'] as $sh): ?>
                        <a class="showtime-chip" href="seats.php?show_id=<?= $sh['show_id'] ?>">
                            <?= format_show_time($sh['show_time']) ?>
                        </a>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endforeach; ?>
    <?php endforeach; ?>
<?php endif; ?>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
