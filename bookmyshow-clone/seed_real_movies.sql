-- ============================================================
-- ShowTime seed data: 119 real movie titles (with placeholder
-- photo posters) and showtimes for the 'now showing' titles.
--
-- These are real, well-known movie titles (titles/facts are not
-- copyrighted). Posters here are Picsum stock-photo placeholders,
-- NOT the official studio poster art -- Claude can't source or
-- redistribute copyrighted poster images. To show the *real*
-- official posters, integrate the free TMDb API (see chat) or
-- upload real poster files yourself via the admin panel.
--
-- SAFE TO RUN ON YOUR EXISTING DATABASE: only INSERTs, never
-- drops or truncates. Requires database.sql to have been run
-- already (so theaters/screens have data).
-- ============================================================

USE bookmyshow_clone;

-- 1. Kabhi Khushi Kabhie Gham
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Kabhi Khushi Kabhie Gham', 'An unforgettable journey across love, loss, and redemption.', 'Drama, Family', 'Hindi', 210, 'https://picsum.photos/seed/showtime-real-1/400/600', DATE_ADD(CURDATE(), INTERVAL -45 DAY), 7.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 170, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 180, 280, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 2. Zindagi Na Milegi Dobara
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Zindagi Na Milegi Dobara', 'When the past resurfaces, nothing will ever be the same again.', 'Drama, Adventure', 'Hindi', 155, 'https://picsum.photos/seed/showtime-real-2/400/600', DATE_ADD(CURDATE(), INTERVAL -55 DAY), 9.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '12:15:00', 150, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '09:30:00', 180, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 160, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 3. Jai Bhim
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Jai Bhim', 'Friendship is tested when the truth finally comes to light.', 'Drama, Crime', 'Tamil', 164, 'https://picsum.photos/seed/showtime-real-3/400/600', DATE_ADD(CURDATE(), INTERVAL -53 DAY), 8.1, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '18:00:00', 170, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 170, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 4. Masaan
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Masaan', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Drama', 'Hindi', 109, 'https://picsum.photos/seed/showtime-real-4/400/600', DATE_ADD(CURDATE(), INTERVAL -14 DAY), 7.5, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 160, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 140, 230, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 5. The Matrix
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Matrix', 'When the past resurfaces, nothing will ever be the same again.', 'Sci-Fi, Action', 'English', 136, 'https://picsum.photos/seed/showtime-real-5/400/600', DATE_ADD(CURDATE(), INTERVAL -48 DAY), 6.9, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 160, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 140, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 6. 96
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('96', 'Against all odds, a small team must save everything they love.', 'Romance, Drama', 'Tamil', 158, 'https://picsum.photos/seed/showtime-real-6/400/600', DATE_ADD(CURDATE(), INTERVAL -33 DAY), 7.9, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 160, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 180, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;

-- 7. Frozen
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Frozen', 'Two rivals, one destiny, and a battle that will define a generation.', 'Animation, Musical', 'English', 102, 'https://picsum.photos/seed/showtime-real-7/400/600', DATE_ADD(CURDATE(), INTERVAL -38 DAY), 9.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 150, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '15:00:00', 180, 280, 430 FROM screens ORDER BY RAND() LIMIT 1;

-- 8. Baahubali: The Beginning
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Baahubali: The Beginning', 'A comedy of errors that turns a quiet town upside down.', 'Action, Fantasy', 'Telugu', 159, 'https://picsum.photos/seed/showtime-real-8/400/600', DATE_ADD(CURDATE(), INTERVAL -28 DAY), 8.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 150, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '12:15:00', 160, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 9. Whiplash
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Whiplash', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Drama, Music', 'English', 106, 'https://picsum.photos/seed/showtime-real-9/400/600', DATE_ADD(CURDATE(), INTERVAL -3 DAY), 8.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '15:00:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 160, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 10. The Dark Knight
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Dark Knight', 'Friendship is tested when the truth finally comes to light.', 'Action, Crime', 'English', 152, 'https://picsum.photos/seed/showtime-real-10/400/600', DATE_ADD(CURDATE(), INTERVAL -79 DAY), 9.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '09:30:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 11. KGF: Chapter 1
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('KGF: Chapter 1', 'A story of ordinary people caught in an extraordinary storm.', 'Action, Drama', 'Kannada', 156, 'https://picsum.photos/seed/showtime-real-11/400/600', DATE_ADD(CURDATE(), INTERVAL -55 DAY), 8.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 150, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 140, 230, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 12. Joker
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Joker', 'One family, one secret, and a city that refuses to forgive.', 'Crime, Drama', 'English', 122, 'https://picsum.photos/seed/showtime-real-12/400/600', DATE_ADD(CURDATE(), INTERVAL -59 DAY), 8.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '12:15:00', 140, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 140, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 13. Leo
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Leo', 'A high-stakes chase that spans continents and shatters loyalties.', 'Action, Thriller', 'Tamil', 164, 'https://picsum.photos/seed/showtime-real-13/400/600', DATE_ADD(CURDATE(), INTERVAL -27 DAY), 7.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '12:15:00', 180, 290, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 180, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 150, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '22:45:00', 140, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;

-- 14. Inside Out
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Inside Out', 'A comedy of errors that turns a quiet town upside down.', 'Animation, Family', 'English', 95, 'https://picsum.photos/seed/showtime-real-14/400/600', DATE_ADD(CURDATE(), INTERVAL -77 DAY), 6.5, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 140, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 160, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;

-- 15. October
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('October', 'A comedy of errors that turns a quiet town upside down.', 'Drama, Romance', 'Hindi', 115, 'https://picsum.photos/seed/showtime-real-15/400/600', DATE_ADD(CURDATE(), INTERVAL -67 DAY), 8.1, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 160, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '22:45:00', 180, 280, 430 FROM screens ORDER BY RAND() LIMIT 1;

-- 16. Finding Nemo
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Finding Nemo', 'A soldier''s return home reveals wounds deeper than the war itself.', 'Animation, Family', 'English', 100, 'https://picsum.photos/seed/showtime-real-16/400/600', DATE_ADD(CURDATE(), INTERVAL -3 DAY), 8.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 160, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 17. Dangal
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Dangal', 'A relentless pursuit of justice against overwhelming odds.', 'Sports, Drama', 'Hindi', 161, 'https://picsum.photos/seed/showtime-real-17/400/600', DATE_ADD(CURDATE(), INTERVAL -68 DAY), 8.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 140, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 18. The Lion King
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Lion King', 'A high-stakes chase that spans continents and shatters loyalties.', 'Animation, Family', 'English', 118, 'https://picsum.photos/seed/showtime-real-18/400/600', DATE_ADD(CURDATE(), INTERVAL -40 DAY), 6.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 160, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 140, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 19. Get Out
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Get Out', 'Two rivals, one destiny, and a battle that will define a generation.', 'Horror, Thriller', 'English', 104, 'https://picsum.photos/seed/showtime-real-19/400/600', DATE_ADD(CURDATE(), INTERVAL -20 DAY), 9.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 20. Everything Everywhere All at Once
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Everything Everywhere All at Once', 'A relentless pursuit of justice against overwhelming odds.', 'Sci-Fi, Comedy', 'English', 140, 'https://picsum.photos/seed/showtime-real-20/400/600', DATE_ADD(CURDATE(), INTERVAL -46 DAY), 6.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 180, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 150, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 21. Dune
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Dune', 'One family, one secret, and a city that refuses to forgive.', 'Sci-Fi, Adventure', 'English', 155, 'https://picsum.photos/seed/showtime-real-21/400/600', DATE_ADD(CURDATE(), INTERVAL -23 DAY), 7.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 160, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 140, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 22. Arrival
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Arrival', 'A comedy of errors that turns a quiet town upside down.', 'Sci-Fi, Drama', 'English', 116, 'https://picsum.photos/seed/showtime-real-22/400/600', DATE_ADD(CURDATE(), INTERVAL -2 DAY), 8.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 170, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 150, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 23. Rocky Aur Rani Kii Prem Kahaani
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Rocky Aur Rani Kii Prem Kahaani', 'An unforgettable journey across love, loss, and redemption.', 'Romance, Comedy', 'Hindi', 168, 'https://picsum.photos/seed/showtime-real-23/400/600', DATE_ADD(CURDATE(), INTERVAL -90 DAY), 7.2, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 160, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 180, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 24. 3 Idiots
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('3 Idiots', 'One family, one secret, and a city that refuses to forgive.', 'Comedy, Drama', 'Hindi', 170, 'https://picsum.photos/seed/showtime-real-24/400/600', DATE_ADD(CURDATE(), INTERVAL -57 DAY), 8.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 180, 280, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 170, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 25. The Bourne Identity
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Bourne Identity', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Action, Thriller', 'English', 119, 'https://picsum.photos/seed/showtime-real-25/400/600', DATE_ADD(CURDATE(), INTERVAL -83 DAY), 7.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '15:00:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 140, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 26. Manikarnika: The Queen of Jhansi
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Manikarnika: The Queen of Jhansi', 'Two rivals, one destiny, and a battle that will define a generation.', 'Action, Drama', 'Hindi', 148, 'https://picsum.photos/seed/showtime-real-26/400/600', DATE_ADD(CURDATE(), INTERVAL -7 DAY), 6.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 170, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 160, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 27. Taare Zameen Par
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Taare Zameen Par', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Drama, Family', 'Hindi', 165, 'https://picsum.photos/seed/showtime-real-27/400/600', DATE_ADD(CURDATE(), INTERVAL -70 DAY), 7.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 140, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:00:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '18:00:00', 150, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 28. Interstellar
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Interstellar', 'An unforgettable journey across love, loss, and redemption.', 'Sci-Fi, Drama', 'English', 169, 'https://picsum.photos/seed/showtime-real-28/400/600', DATE_ADD(CURDATE(), INTERVAL -11 DAY), 7.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '18:00:00', 160, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '09:30:00', 150, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 29. Moana
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Moana', 'One family, one secret, and a city that refuses to forgive.', 'Animation, Adventure', 'English', 107, 'https://picsum.photos/seed/showtime-real-29/400/600', DATE_ADD(CURDATE(), INTERVAL -67 DAY), 9.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '12:15:00', 180, 290, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '15:00:00', 180, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 180, 290, 440 FROM screens ORDER BY RAND() LIMIT 1;

-- 30. Inception
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Inception', 'An unforgettable journey across love, loss, and redemption.', 'Sci-Fi, Thriller', 'English', 148, 'https://picsum.photos/seed/showtime-real-30/400/600', DATE_ADD(CURDATE(), INTERVAL -88 DAY), 8.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '22:45:00', 140, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:00:00', 180, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;

-- 31. 12th Fail
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('12th Fail', 'A haunting mystery that unravels one clue at a time.', 'Drama, Biography', 'Hindi', 147, 'https://picsum.photos/seed/showtime-real-31/400/600', DATE_ADD(CURDATE(), INTERVAL -2 DAY), 8.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 140, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 180, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;

-- 32. PK
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('PK', 'Against all odds, a small team must save everything they love.', 'Comedy, Drama', 'Hindi', 153, 'https://picsum.photos/seed/showtime-real-32/400/600', DATE_ADD(CURDATE(), INTERVAL -67 DAY), 6.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 160, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 33. Kantara
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Kantara', 'An unforgettable journey across love, loss, and redemption.', 'Action, Drama', 'Kannada', 150, 'https://picsum.photos/seed/showtime-real-33/400/600', DATE_ADD(CURDATE(), INTERVAL -80 DAY), 8.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 160, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '12:15:00', 150, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 160, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;

-- 34. Top Gun: Maverick
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Top Gun: Maverick', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Action, Drama', 'English', 130, 'https://picsum.photos/seed/showtime-real-34/400/600', DATE_ADD(CURDATE(), INTERVAL -36 DAY), 7.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:00:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 170, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 35. Avatar
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Avatar', 'In a world on the brink, one choice changes everything.', 'Sci-Fi, Adventure', 'English', 162, 'https://picsum.photos/seed/showtime-real-35/400/600', DATE_ADD(CURDATE(), INTERVAL -57 DAY), 9.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 150, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 36. Master
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Master', 'A relentless pursuit of justice against overwhelming odds.', 'Action, Thriller', 'Tamil', 179, 'https://picsum.photos/seed/showtime-real-36/400/600', DATE_ADD(CURDATE(), INTERVAL -77 DAY), 8.9, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '18:00:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 170, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 170, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;

-- 37. The Revenant
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Revenant', 'In a world on the brink, one choice changes everything.', 'Adventure, Drama', 'English', 156, 'https://picsum.photos/seed/showtime-real-37/400/600', DATE_ADD(CURDATE(), INTERVAL -18 DAY), 7.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 140, 230, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 140, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 38. Dilwale Dulhania Le Jayenge
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Dilwale Dulhania Le Jayenge', 'Two rivals, one destiny, and a battle that will define a generation.', 'Romance, Drama', 'Hindi', 190, 'https://picsum.photos/seed/showtime-real-38/400/600', DATE_ADD(CURDATE(), INTERVAL -50 DAY), 7.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 160, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:00:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 180, 280, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 39. Pushpa: The Rise
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Pushpa: The Rise', 'A soldier''s return home reveals wounds deeper than the war itself.', 'Action, Drama', 'Telugu', 179, 'https://picsum.photos/seed/showtime-real-39/400/600', DATE_ADD(CURDATE(), INTERVAL -80 DAY), 7.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 150, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 170, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '15:00:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 40. Baby Driver
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Baby Driver', 'Against all odds, a small team must save everything they love.', 'Action, Crime', 'English', 113, 'https://picsum.photos/seed/showtime-real-40/400/600', DATE_ADD(CURDATE(), INTERVAL -38 DAY), 7.2, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 150, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '18:00:00', 140, 230, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '21:15:00', 170, 280, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 41. Barfi!
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Barfi!', 'A high-stakes chase that spans continents and shatters loyalties.', 'Comedy, Drama', 'Hindi', 151, 'https://picsum.photos/seed/showtime-real-41/400/600', DATE_ADD(CURDATE(), INTERVAL -54 DAY), 6.9, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 140, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 160, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 42. Sita Ramam
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Sita Ramam', 'Against all odds, a small team must save everything they love.', 'Romance, Drama', 'Telugu', 163, 'https://picsum.photos/seed/showtime-real-42/400/600', DATE_ADD(CURDATE(), INTERVAL -25 DAY), 9.1, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 160, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '12:15:00', 170, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 160, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 43. Wonder Woman
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Wonder Woman', 'A comedy of errors that turns a quiet town upside down.', 'Action, Fantasy', 'English', 141, 'https://picsum.photos/seed/showtime-real-43/400/600', DATE_ADD(CURDATE(), INTERVAL -64 DAY), 8.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 170, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '18:00:00', 170, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 44. 1917
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('1917', 'Against all odds, a small team must save everything they love.', 'War, Drama', 'English', 119, 'https://picsum.photos/seed/showtime-real-44/400/600', DATE_ADD(CURDATE(), INTERVAL -16 DAY), 6.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 170, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 150, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 45. Birdman
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Birdman', 'A comedy of errors that turns a quiet town upside down.', 'Drama, Comedy', 'English', 119, 'https://picsum.photos/seed/showtime-real-45/400/600', DATE_ADD(CURDATE(), INTERVAL -89 DAY), 8.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 160, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 160, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 170, 280, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 46. Kahaani
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Kahaani', 'A relentless pursuit of justice against overwhelming odds.', 'Thriller, Mystery', 'Hindi', 122, 'https://picsum.photos/seed/showtime-real-46/400/600', DATE_ADD(CURDATE(), INTERVAL -12 DAY), 6.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 160, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 160, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 170, 280, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '15:00:00', 180, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 47. A Quiet Place
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('A Quiet Place', 'When the past resurfaces, nothing will ever be the same again.', 'Horror, Sci-Fi', 'English', 90, 'https://picsum.photos/seed/showtime-real-47/400/600', DATE_ADD(CURDATE(), INTERVAL -52 DAY), 8.5, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '18:00:00', 140, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 170, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 48. Stree
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Stree', 'A story of ordinary people caught in an extraordinary storm.', 'Horror, Comedy', 'Hindi', 128, 'https://picsum.photos/seed/showtime-real-48/400/600', DATE_ADD(CURDATE(), INTERVAL -63 DAY), 6.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '12:15:00', 180, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 49. Blade Runner 2049
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Blade Runner 2049', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Sci-Fi, Drama', 'English', 164, 'https://picsum.photos/seed/showtime-real-49/400/600', DATE_ADD(CURDATE(), INTERVAL -13 DAY), 9.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 180, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '12:15:00', 140, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 50. Barbie
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Barbie', 'An unforgettable journey across love, loss, and redemption.', 'Comedy, Fantasy', 'English', 114, 'https://picsum.photos/seed/showtime-real-50/400/600', DATE_ADD(CURDATE(), INTERVAL -40 DAY), 8.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '12:15:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 51. Sam Bahadur
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Sam Bahadur', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Biography, Drama', 'Hindi', 150, 'https://picsum.photos/seed/showtime-real-51/400/600', DATE_ADD(CURDATE(), INTERVAL -56 DAY), 7.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 140, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '18:00:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 52. Newton
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Newton', 'Against all odds, a small team must save everything they love.', 'Drama, Comedy', 'Hindi', 106, 'https://picsum.photos/seed/showtime-real-52/400/600', DATE_ADD(CURDATE(), INTERVAL -55 DAY), 6.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 160, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 140, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 150, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 53. Rang De Basanti
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Rang De Basanti', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Drama', 'Hindi', 167, 'https://picsum.photos/seed/showtime-real-53/400/600', DATE_ADD(CURDATE(), INTERVAL -5 DAY), 7.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 180, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 160, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 54. Salaar: Part 1 – Ceasefire
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Salaar: Part 1 – Ceasefire', 'Against all odds, a small team must save everything they love.', 'Action, Drama', 'Telugu', 175, 'https://picsum.photos/seed/showtime-real-54/400/600', DATE_ADD(CURDATE(), INTERVAL -5 DAY), 7.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '22:45:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 170, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 170, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 170, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 55. Animal
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Animal', 'A comedy of errors that turns a quiet town upside down.', 'Action, Drama', 'Hindi', 201, 'https://picsum.photos/seed/showtime-real-55/400/600', DATE_ADD(CURDATE(), INTERVAL -38 DAY), 8.9, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:00:00', 170, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '22:45:00', 140, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 56. Zootopia
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Zootopia', 'A high-stakes chase that spans continents and shatters loyalties.', 'Animation, Comedy', 'English', 108, 'https://picsum.photos/seed/showtime-real-56/400/600', DATE_ADD(CURDATE(), INTERVAL -50 DAY), 8.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '15:00:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;

-- 57. Drishyam
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Drishyam', 'Against all odds, a small team must save everything they love.', 'Thriller, Crime', 'Hindi', 163, 'https://picsum.photos/seed/showtime-real-57/400/600', DATE_ADD(CURDATE(), INTERVAL -53 DAY), 7.9, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '18:00:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 160, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 180, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 58. Mad Max: Fury Road
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Mad Max: Fury Road', 'A high-stakes chase that spans continents and shatters loyalties.', 'Action, Adventure', 'English', 120, 'https://picsum.photos/seed/showtime-real-58/400/600', DATE_ADD(CURDATE(), INTERVAL -32 DAY), 8.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 180, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 140, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '15:00:00', 150, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 59. Black Panther
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Black Panther', 'An unforgettable journey across love, loss, and redemption.', 'Action, Adventure', 'English', 134, 'https://picsum.photos/seed/showtime-real-59/400/600', DATE_ADD(CURDATE(), INTERVAL -29 DAY), 8.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '18:00:00', 140, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 180, 290, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '21:15:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 60. The Grand Budapest Hotel
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Grand Budapest Hotel', 'When the past resurfaces, nothing will ever be the same again.', 'Comedy, Drama', 'English', 100, 'https://picsum.photos/seed/showtime-real-60/400/600', DATE_ADD(CURDATE(), INTERVAL -22 DAY), 7.8, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 150, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', 160, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '15:00:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '22:45:00', 170, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;

-- 61. Super Deluxe
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Super Deluxe', 'An unforgettable journey across love, loss, and redemption.', 'Drama, Thriller', 'Tamil', 176, 'https://picsum.photos/seed/showtime-real-61/400/600', DATE_ADD(CURDATE(), INTERVAL -23 DAY), 8.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 140, 240, 360 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '18:00:00', 170, 280, 430 FROM screens ORDER BY RAND() LIMIT 1;

-- 62. Moonlight
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Moonlight', 'An unforgettable journey across love, loss, and redemption.', 'Drama', 'English', 111, 'https://picsum.photos/seed/showtime-real-62/400/600', DATE_ADD(CURDATE(), INTERVAL -19 DAY), 8.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '15:00:00', 180, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '21:15:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 150, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 63. Oppenheimer
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Oppenheimer', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Biography, Drama', 'English', 180, 'https://picsum.photos/seed/showtime-real-63/400/600', DATE_ADD(CURDATE(), INTERVAL -51 DAY), 7.1, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 170, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 140, 230, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 150, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 64. Lagaan
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Lagaan', 'A soldier''s return home reveals wounds deeper than the war itself.', 'Sports, Drama', 'Hindi', 224, 'https://picsum.photos/seed/showtime-real-64/400/600', DATE_ADD(CURDATE(), INTERVAL -11 DAY), 8.2, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 180, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '22:45:00', 140, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 150, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;

-- 65. The Social Network
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Social Network', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Drama, Biography', 'English', 120, 'https://picsum.photos/seed/showtime-real-65/400/600', DATE_ADD(CURDATE(), INTERVAL -5 DAY), 9.3, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '22:45:00', 150, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '21:15:00', 180, 270, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 150, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 66. Talvar
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Talvar', 'A relentless pursuit of justice against overwhelming odds.', 'Crime, Drama', 'Hindi', 132, 'https://picsum.photos/seed/showtime-real-66/400/600', DATE_ADD(CURDATE(), INTERVAL -5 DAY), 7.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 150, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '12:15:00', 140, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 67. Baahubali 2: The Conclusion
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Baahubali 2: The Conclusion', 'A story of ordinary people caught in an extraordinary storm.', 'Action, Fantasy', 'Telugu', 167, 'https://picsum.photos/seed/showtime-real-67/400/600', DATE_ADD(CURDATE(), INTERVAL -4 DAY), 8.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '21:15:00', 170, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '15:00:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 68. Soorarai Pottru
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Soorarai Pottru', 'A relentless pursuit of justice against overwhelming odds.', 'Drama, Biography', 'Tamil', 153, 'https://picsum.photos/seed/showtime-real-68/400/600', DATE_ADD(CURDATE(), INTERVAL -84 DAY), 7.6, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 150, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 170, 260, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '22:45:00', 170, 260, 380 FROM screens ORDER BY RAND() LIMIT 1;

-- 69. Tenet
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Tenet', 'A story of ordinary people caught in an extraordinary storm.', 'Sci-Fi, Action', 'English', 150, 'https://picsum.photos/seed/showtime-real-69/400/600', DATE_ADD(CURDATE(), INTERVAL -16 DAY), 7.5, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:30:00', 140, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '12:15:00', 180, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 70. La La Land
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('La La Land', 'A haunting mystery that unravels one clue at a time.', 'Musical, Romance', 'English', 128, 'https://picsum.photos/seed/showtime-real-70/400/600', DATE_ADD(CURDATE(), INTERVAL -64 DAY), 9.1, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '21:15:00', 150, 240, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 160, 250, 400 FROM screens ORDER BY RAND() LIMIT 1;

-- 71. Goodfellas
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Goodfellas', 'A story of ordinary people caught in an extraordinary storm.', 'Crime, Drama', 'English', 146, 'https://picsum.photos/seed/showtime-real-71/400/600', DATE_ADD(CURDATE(), INTERVAL -28 DAY), 6.7, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:00:00', 170, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 160, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 150, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '22:45:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;

-- 72. Parasite
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Parasite', 'A soldier''s return home reveals wounds deeper than the war itself.', 'Thriller, Drama', 'English', 132, 'https://picsum.photos/seed/showtime-real-72/400/600', DATE_ADD(CURDATE(), INTERVAL -51 DAY), 7.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '15:00:00', 160, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '09:30:00', 180, 290, 440 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '21:15:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 73. Badhaai Ho
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Badhaai Ho', 'Against all odds, a small team must save everything they love.', 'Comedy, Drama', 'Hindi', 124, 'https://picsum.photos/seed/showtime-real-73/400/600', DATE_ADD(CURDATE(), INTERVAL -80 DAY), 9.0, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '21:15:00', 160, 250, 380 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:15:00', 150, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 140, 240, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 74. John Wick
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('John Wick', 'Two rivals, one destiny, and a battle that will define a generation.', 'Action, Thriller', 'English', 101, 'https://picsum.photos/seed/showtime-real-74/400/600', DATE_ADD(CURDATE(), INTERVAL -32 DAY), 7.4, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '12:15:00', 170, 270, 420 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '22:45:00', 160, 250, 370 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 3 DAY), '15:00:00', 170, 260, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '18:00:00', 140, 230, 350 FROM screens ORDER BY RAND() LIMIT 1;

-- 75. Piku
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Piku', 'When the past resurfaces, nothing will ever be the same again.', 'Comedy, Drama', 'Hindi', 125, 'https://picsum.photos/seed/showtime-real-75/400/600', DATE_ADD(CURDATE(), INTERVAL 0 DAY), 8.1, 'now_showing');
SET @mid = LAST_INSERT_ID();
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '21:15:00', 170, 280, 410 FROM screens ORDER BY RAND() LIMIT 1;
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) SELECT @mid, id, DATE_ADD(CURDATE(), INTERVAL 4 DAY), '12:15:00', 180, 270, 390 FROM screens ORDER BY RAND() LIMIT 1;

-- 76. Jawan
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Jawan', 'Friendship is tested when the truth finally comes to light.', 'Action, Thriller', 'Hindi', 169, 'https://picsum.photos/seed/showtime-real-76/400/600', DATE_ADD(CURDATE(), INTERVAL 100 DAY), 0.0, 'coming_soon');

-- 77. Gully Boy
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Gully Boy', 'One family, one secret, and a city that refuses to forgive.', 'Drama, Music', 'Hindi', 154, 'https://picsum.photos/seed/showtime-real-77/400/600', DATE_ADD(CURDATE(), INTERVAL 128 DAY), 0.0, 'coming_soon');

-- 78. Iron Man
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Iron Man', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Action, Sci-Fi', 'English', 126, 'https://picsum.photos/seed/showtime-real-78/400/600', DATE_ADD(CURDATE(), INTERVAL 41 DAY), 0.0, 'coming_soon');

-- 79. RRR
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('RRR', 'Against all odds, a small team must save everything they love.', 'Action, Drama', 'Telugu', 187, 'https://picsum.photos/seed/showtime-real-79/400/600', DATE_ADD(CURDATE(), INTERVAL 69 DAY), 0.0, 'coming_soon');

-- 80. Knives Out
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Knives Out', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Mystery, Comedy', 'English', 130, 'https://picsum.photos/seed/showtime-real-80/400/600', DATE_ADD(CURDATE(), INTERVAL 45 DAY), 0.0, 'coming_soon');

-- 81. The Avengers
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Avengers', 'An unforgettable journey across love, loss, and redemption.', 'Action, Sci-Fi', 'English', 143, 'https://picsum.photos/seed/showtime-real-81/400/600', DATE_ADD(CURDATE(), INTERVAL 31 DAY), 0.0, 'coming_soon');

-- 82. Article 15
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Article 15', 'One family, one secret, and a city that refuses to forgive.', 'Crime, Drama', 'Hindi', 130, 'https://picsum.photos/seed/showtime-real-82/400/600', DATE_ADD(CURDATE(), INTERVAL 170 DAY), 0.0, 'coming_soon');

-- 83. Fight Club
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Fight Club', 'A comedy of errors that turns a quiet town upside down.', 'Drama', 'English', 139, 'https://picsum.photos/seed/showtime-real-83/400/600', DATE_ADD(CURDATE(), INTERVAL 177 DAY), 0.0, 'coming_soon');

-- 84. Pathaan
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Pathaan', 'In a world on the brink, one choice changes everything.', 'Action, Thriller', 'Hindi', 146, 'https://picsum.photos/seed/showtime-real-84/400/600', DATE_ADD(CURDATE(), INTERVAL 76 DAY), 0.0, 'coming_soon');

-- 85. Vikram Vedha
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Vikram Vedha', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Action, Thriller', 'Tamil', 147, 'https://picsum.photos/seed/showtime-real-85/400/600', DATE_ADD(CURDATE(), INTERVAL 74 DAY), 0.0, 'coming_soon');

-- 86. Ponniyin Selvan: Part One
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Ponniyin Selvan: Part One', 'A haunting mystery that unravels one clue at a time.', 'Action, Drama', 'Tamil', 167, 'https://picsum.photos/seed/showtime-real-86/400/600', DATE_ADD(CURDATE(), INTERVAL 21 DAY), 0.0, 'coming_soon');

-- 87. Raazi
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Raazi', 'A soldier''s return home reveals wounds deeper than the war itself.', 'Thriller, Drama', 'Hindi', 138, 'https://picsum.photos/seed/showtime-real-87/400/600', DATE_ADD(CURDATE(), INTERVAL 150 DAY), 0.0, 'coming_soon');

-- 88. Bajrangi Bhaijaan
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Bajrangi Bhaijaan', 'Friendship is tested when the truth finally comes to light.', 'Drama, Comedy', 'Hindi', 163, 'https://picsum.photos/seed/showtime-real-88/400/600', DATE_ADD(CURDATE(), INTERVAL 96 DAY), 0.0, 'coming_soon');

-- 89. Gadar 2
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Gadar 2', 'Friendship is tested when the truth finally comes to light.', 'Action, Drama', 'Hindi', 170, 'https://picsum.photos/seed/showtime-real-89/400/600', DATE_ADD(CURDATE(), INTERVAL 172 DAY), 0.0, 'coming_soon');

-- 90. Asuran
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Asuran', 'Friendship is tested when the truth finally comes to light.', 'Action, Drama', 'Tamil', 141, 'https://picsum.photos/seed/showtime-real-90/400/600', DATE_ADD(CURDATE(), INTERVAL 120 DAY), 0.0, 'coming_soon');

-- 91. War
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('War', 'Against all odds, a small team must save everything they love.', 'Action, Thriller', 'Hindi', 154, 'https://picsum.photos/seed/showtime-real-91/400/600', DATE_ADD(CURDATE(), INTERVAL 139 DAY), 0.0, 'coming_soon');

-- 92. Pink
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Pink', 'A high-stakes chase that spans continents and shatters loyalties.', 'Drama, Thriller', 'Hindi', 136, 'https://picsum.photos/seed/showtime-real-92/400/600', DATE_ADD(CURDATE(), INTERVAL 133 DAY), 0.0, 'coming_soon');

-- 93. Inglourious Basterds
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Inglourious Basterds', 'A soldier''s return home reveals wounds deeper than the war itself.', 'War, Drama', 'English', 153, 'https://picsum.photos/seed/showtime-real-93/400/600', DATE_ADD(CURDATE(), INTERVAL 49 DAY), 0.0, 'coming_soon');

-- 94. Toy Story
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Toy Story', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Animation, Family', 'English', 81, 'https://picsum.photos/seed/showtime-real-94/400/600', DATE_ADD(CURDATE(), INTERVAL 7 DAY), 0.0, 'coming_soon');

-- 95. Uri: The Surgical Strike
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Uri: The Surgical Strike', 'A relentless pursuit of justice against overwhelming odds.', 'Action, War', 'Hindi', 138, 'https://picsum.photos/seed/showtime-real-95/400/600', DATE_ADD(CURDATE(), INTERVAL 22 DAY), 0.0, 'coming_soon');

-- 96. Kaithi
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Kaithi', 'In a world on the brink, one choice changes everything.', 'Action, Thriller', 'Tamil', 145, 'https://picsum.photos/seed/showtime-real-96/400/600', DATE_ADD(CURDATE(), INTERVAL 13 DAY), 0.0, 'coming_soon');

-- 97. Up
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Up', 'A high-stakes chase that spans continents and shatters loyalties.', 'Animation, Adventure', 'English', 96, 'https://picsum.photos/seed/showtime-real-97/400/600', DATE_ADD(CURDATE(), INTERVAL 54 DAY), 0.0, 'coming_soon');

-- 98. Andhadhun
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Andhadhun', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Thriller, Comedy', 'Hindi', 139, 'https://picsum.photos/seed/showtime-real-98/400/600', DATE_ADD(CURDATE(), INTERVAL 47 DAY), 0.0, 'coming_soon');

-- 99. KGF: Chapter 2
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('KGF: Chapter 2', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Action, Drama', 'Kannada', 168, 'https://picsum.photos/seed/showtime-real-99/400/600', DATE_ADD(CURDATE(), INTERVAL 33 DAY), 0.0, 'coming_soon');

-- 100. Dunkirk
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Dunkirk', 'A relentless pursuit of justice against overwhelming odds.', 'War, Drama', 'English', 106, 'https://picsum.photos/seed/showtime-real-100/400/600', DATE_ADD(CURDATE(), INTERVAL 163 DAY), 0.0, 'coming_soon');

-- 101. Gladiator
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Gladiator', 'A high-stakes chase that spans continents and shatters loyalties.', 'Action, Drama', 'English', 155, 'https://picsum.photos/seed/showtime-real-101/400/600', DATE_ADD(CURDATE(), INTERVAL 175 DAY), 0.0, 'coming_soon');

-- 102. Coco
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Coco', 'In a world on the brink, one choice changes everything.', 'Animation, Family', 'English', 105, 'https://picsum.photos/seed/showtime-real-102/400/600', DATE_ADD(CURDATE(), INTERVAL 43 DAY), 0.0, 'coming_soon');

-- 103. WALL-E
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('WALL-E', 'A relentless pursuit of justice against overwhelming odds.', 'Animation, Sci-Fi', 'English', 98, 'https://picsum.photos/seed/showtime-real-103/400/600', DATE_ADD(CURDATE(), INTERVAL 58 DAY), 0.0, 'coming_soon');

-- 104. Jurassic Park
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Jurassic Park', 'A haunting mystery that unravels one clue at a time.', 'Adventure, Sci-Fi', 'English', 127, 'https://picsum.photos/seed/showtime-real-104/400/600', DATE_ADD(CURDATE(), INTERVAL 162 DAY), 0.0, 'coming_soon');

-- 105. Pulp Fiction
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Pulp Fiction', 'A haunting mystery that unravels one clue at a time.', 'Crime, Drama', 'English', 154, 'https://picsum.photos/seed/showtime-real-105/400/600', DATE_ADD(CURDATE(), INTERVAL 136 DAY), 0.0, 'coming_soon');

-- 106. Django Unchained
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Django Unchained', 'In a world on the brink, one choice changes everything.', 'Western, Drama', 'English', 165, 'https://picsum.photos/seed/showtime-real-106/400/600', DATE_ADD(CURDATE(), INTERVAL 171 DAY), 0.0, 'coming_soon');

-- 107. Sholay
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Sholay', 'One family, one secret, and a city that refuses to forgive.', 'Action, Drama', 'Hindi', 204, 'https://picsum.photos/seed/showtime-real-107/400/600', DATE_ADD(CURDATE(), INTERVAL 163 DAY), 0.0, 'coming_soon');

-- 108. The Shawshank Redemption
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Shawshank Redemption', 'When the past resurfaces, nothing will ever be the same again.', 'Drama', 'English', 142, 'https://picsum.photos/seed/showtime-real-108/400/600', DATE_ADD(CURDATE(), INTERVAL 137 DAY), 0.0, 'coming_soon');

-- 109. Chak De! India
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Chak De! India', 'When the past resurfaces, nothing will ever be the same again.', 'Sports, Drama', 'Hindi', 153, 'https://picsum.photos/seed/showtime-real-109/400/600', DATE_ADD(CURDATE(), INTERVAL 23 DAY), 0.0, 'coming_soon');

-- 110. No Time to Die
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('No Time to Die', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Action, Thriller', 'English', 163, 'https://picsum.photos/seed/showtime-real-110/400/600', DATE_ADD(CURDATE(), INTERVAL 167 DAY), 0.0, 'coming_soon');

-- 111. The Godfather
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('The Godfather', 'Against all odds, a small team must save everything they love.', 'Crime, Drama', 'English', 175, 'https://picsum.photos/seed/showtime-real-111/400/600', DATE_ADD(CURDATE(), INTERVAL 129 DAY), 0.0, 'coming_soon');

-- 112. Queen
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Queen', 'A gripping tale of courage that pushes its heroes to the very edge.', 'Drama, Comedy', 'Hindi', 146, 'https://picsum.photos/seed/showtime-real-112/400/600', DATE_ADD(CURDATE(), INTERVAL 144 DAY), 0.0, 'coming_soon');

-- 113. Vikram
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Vikram', 'Two rivals, one destiny, and a battle that will define a generation.', 'Action, Thriller', 'Tamil', 174, 'https://picsum.photos/seed/showtime-real-113/400/600', DATE_ADD(CURDATE(), INTERVAL 103 DAY), 0.0, 'coming_soon');

-- 114. Titanic
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Titanic', 'Against all odds, a small team must save everything they love.', 'Romance, Drama', 'English', 195, 'https://picsum.photos/seed/showtime-real-114/400/600', DATE_ADD(CURDATE(), INTERVAL 118 DAY), 0.0, 'coming_soon');

-- 115. Forrest Gump
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Forrest Gump', 'An unforgettable journey across love, loss, and redemption.', 'Drama, Romance', 'English', 142, 'https://picsum.photos/seed/showtime-real-115/400/600', DATE_ADD(CURDATE(), INTERVAL 126 DAY), 0.0, 'coming_soon');

-- 116. Gangs of Wasseypur
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Gangs of Wasseypur', 'Love, betrayal, and ambition collide in this sweeping saga.', 'Crime, Drama', 'Hindi', 160, 'https://picsum.photos/seed/showtime-real-116/400/600', DATE_ADD(CURDATE(), INTERVAL 174 DAY), 0.0, 'coming_soon');

-- 117. Her
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Her', 'A high-stakes chase that spans continents and shatters loyalties.', 'Drama, Romance', 'English', 126, 'https://picsum.photos/seed/showtime-real-117/400/600', DATE_ADD(CURDATE(), INTERVAL 51 DAY), 0.0, 'coming_soon');

-- 118. Spider-Man: No Way Home
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Spider-Man: No Way Home', 'When the past resurfaces, nothing will ever be the same again.', 'Action, Adventure', 'English', 148, 'https://picsum.photos/seed/showtime-real-118/400/600', DATE_ADD(CURDATE(), INTERVAL 33 DAY), 0.0, 'coming_soon');

-- 119. Mission: Impossible – Fallout
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES ('Mission: Impossible – Fallout', 'A haunting mystery that unravels one clue at a time.', 'Action, Thriller', 'English', 147, 'https://picsum.photos/seed/showtime-real-119/400/600', DATE_ADD(CURDATE(), INTERVAL 66 DAY), 0.0, 'coming_soon');
