-- ============================================================
-- PATCH SCRIPT — run this ONLY if you already imported the old
-- database.sql and don't want to drop/re-import everything.
-- It fixes the broken admin login and adds more cities/theaters.
-- Safe to run multiple times.
-- ============================================================

USE bookmyshow_clone;

-- 1) Fix the admin login (this is the "Invalid email or password" bug —
--    the old seed data inserted an empty password hash)
UPDATE users
SET password = '$2b$10$UC3WamfsrLzS4CSmIYaLceiETEtSvtQUPvNr8tX6ik7AwPY.9MOgy'
WHERE email = 'admin@bms.com';
-- Login with: admin@bms.com / admin123

-- 2) Add more cities/theaters if they don't already exist
INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'PVR - Select Citywalk' , 'Delhi-NCR', 'Select Citywalk, Saket, New Delhi') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'PVR - Select Citywalk');

INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'INOX - Nexus Mall', 'Ahmedabad', 'Nexus Mall, Ambli, Ahmedabad') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'INOX - Nexus Mall');

INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'Cinepolis - Crystal Mall', 'Rajkot', 'Crystal Mall, 150 Feet Ring Road, Rajkot') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'Cinepolis - Crystal Mall');

INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'PVR - Forum Sujana Mall', 'Hyderabad', 'Forum Sujana Mall, Kukatpally, Hyderabad') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'PVR - Forum Sujana Mall');

INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'INOX - Phoenix Marketcity', 'Pune', 'Phoenix Marketcity, Viman Nagar, Pune') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'INOX - Phoenix Marketcity');

INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'PVR - South City Mall', 'Kolkata', 'South City Mall, Jodhpur Park, Kolkata') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'PVR - South City Mall');

INSERT INTO theaters (name, city, address)
SELECT * FROM (SELECT 'Cinepolis - VR Chennai', 'Chennai', 'VR Chennai, Anna Nagar, Chennai') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM theaters WHERE name = 'Cinepolis - VR Chennai');

-- 3) Add a screen for each newly added theater (only if missing)
INSERT INTO screens (theater_id, name, rows_count, cols_count)
SELECT t.id, 'Screen 1', 6, 10
FROM theaters t
WHERE NOT EXISTS (SELECT 1 FROM screens sc WHERE sc.theater_id = t.id);

-- 4) Give the new theaters a couple of shows for today, reusing existing movies
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner)
SELECT m.id, sc.id, CURDATE(), '18:00:00', 160, 260, 420
FROM screens sc
JOIN theaters t ON sc.theater_id = t.id
JOIN movies m ON m.id = ((sc.id % 4) + 1)
WHERE t.city IN ('Delhi-NCR','Ahmedabad','Rajkot','Hyderabad','Pune','Kolkata','Chennai')
  AND NOT EXISTS (SELECT 1 FROM shows s WHERE s.screen_id = sc.id);
