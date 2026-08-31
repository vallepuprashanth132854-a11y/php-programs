-- ============================================================
-- BookMyShow Clone - Database Schema
-- ============================================================
-- IMPORTANT: this script wipes and rebuilds the database from
-- scratch every time you import it, so it always leaves you with
-- a guaranteed-working admin login. If you previously imported an
-- older copy of this file, just re-run this one — it will replace
-- everything cleanly instead of erroring out on existing tables.
-- ============================================================

DROP DATABASE IF EXISTS bookmyshow_clone;
CREATE DATABASE bookmyshow_clone;
USE bookmyshow_clone;

-- ---------------------------
-- Users
-- ---------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    role ENUM('user','admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------
-- Movies
-- ---------------------------
CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    genre VARCHAR(100),
    language VARCHAR(50),
    duration_mins INT NOT NULL DEFAULT 120,
    poster_url VARCHAR(255),
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0.0,
    status ENUM('now_showing','coming_soon') DEFAULT 'now_showing',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------
-- Theaters
-- ---------------------------
CREATE TABLE theaters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(255)
);

-- ---------------------------
-- Screens (each theater can have multiple screens)
-- ---------------------------
CREATE TABLE screens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    theater_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    rows_count INT NOT NULL DEFAULT 8,
    cols_count INT NOT NULL DEFAULT 10,
    FOREIGN KEY (theater_id) REFERENCES theaters(id) ON DELETE CASCADE
);

-- ---------------------------
-- Seats (generated per screen)
-- ---------------------------
CREATE TABLE seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    screen_id INT NOT NULL,
    seat_row VARCHAR(2) NOT NULL,
    seat_number INT NOT NULL,
    seat_type ENUM('regular','premium','recliner') DEFAULT 'regular',
    FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
);

-- ---------------------------
-- Shows (a movie playing on a screen at a date/time)
-- ---------------------------
CREATE TABLE shows (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    screen_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    price_regular DECIMAL(8,2) NOT NULL DEFAULT 150.00,
    price_premium DECIMAL(8,2) NOT NULL DEFAULT 250.00,
    price_recliner DECIMAL(8,2) NOT NULL DEFAULT 400.00,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
);

-- ---------------------------
-- Bookings
-- ---------------------------
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    booking_code VARCHAR(20) NOT NULL UNIQUE,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE
);

-- ---------------------------
-- Booking Seats (many-to-many: booking <-> seat)
-- ---------------------------
CREATE TABLE booking_seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    show_id INT NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    FOREIGN KEY (seat_id) REFERENCES seats(id) ON DELETE CASCADE,
    UNIQUE KEY unique_seat_per_show (show_id, seat_id)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- Admin user — password is already set (no extra setup step needed)
-- Login: admin@bms.com / admin123
INSERT INTO users (name, email, phone, password, role) VALUES
('Admin', 'admin@bms.com', '9999999999', '$2b$10$UC3WamfsrLzS4CSmIYaLceiETEtSvtQUPvNr8tX6ik7AwPY.9MOgy', 'admin');

-- Theaters (spread across multiple cities so the city selector has real data)
INSERT INTO theaters (name, city, address) VALUES
('PVR Cinemas - Phoenix Mall', 'Mumbai', 'Phoenix Mall, Kurla West, Mumbai'),
('INOX - R City Mall', 'Mumbai', 'R City Mall, Ghatkopar, Mumbai'),
('Cinepolis - Forum Mall', 'Bangalore', 'Forum Mall, Koramangala, Bangalore'),
('PVR - Select Citywalk', 'Delhi-NCR', 'Select Citywalk, Saket, New Delhi'),
('INOX - Nexus Mall', 'Ahmedabad', 'Nexus Mall, Ambli, Ahmedabad'),
('Cinepolis - Crystal Mall', 'Rajkot', 'Crystal Mall, 150 Feet Ring Road, Rajkot'),
('PVR - Forum Sujana Mall', 'Hyderabad', 'Forum Sujana Mall, Kukatpally, Hyderabad'),
('INOX - Phoenix Marketcity', 'Pune', 'Phoenix Marketcity, Viman Nagar, Pune'),
('PVR - South City Mall', 'Kolkata', 'South City Mall, Jodhpur Park, Kolkata'),
('Cinepolis - VR Chennai', 'Chennai', 'VR Chennai, Anna Nagar, Chennai');

-- Screens
INSERT INTO screens (theater_id, name, rows_count, cols_count) VALUES
(1, 'Screen 1', 6, 10),
(1, 'Screen 2', 6, 10),
(2, 'Screen 1', 6, 10),
(3, 'Screen 1', 6, 10),
(4, 'Screen 1', 6, 10),
(5, 'Screen 1', 6, 10),
(6, 'Screen 1', 6, 10),
(7, 'Screen 1', 6, 10),
(8, 'Screen 1', 6, 10),
(9, 'Screen 1', 6, 10),
(10, 'Screen 1', 6, 10);

-- Movies
INSERT INTO movies (title, description, genre, language, duration_mins, poster_url, release_date, rating, status) VALUES
('Pathaan Returns', 'An elite spy is pulled back into action to stop a global threat.', 'Action, Thriller', 'Hindi', 155, 'assets/images/poster1.jpg', '2026-07-15', 8.2, 'now_showing'),
('The Last Horizon', 'A team of astronauts embark on humanity''s final mission to save Earth.', 'Sci-Fi, Drama', 'English', 148, 'assets/images/poster2.jpg', '2026-07-20', 8.7, 'now_showing'),
('Dil Se Dil Tak', 'A heartwarming love story set across two generations.', 'Romance, Drama', 'Hindi', 132, 'assets/images/poster3.jpg', '2026-08-01', 7.5, 'now_showing'),
('Shadow Protocol', 'A rogue hacker uncovers a global conspiracy hidden in plain sight.', 'Action, Mystery', 'English', 140, 'assets/images/poster4.jpg', '2026-08-05', 7.9, 'now_showing'),
('Comedy Nights Unlimited', 'A laugh riot following three friends on a chaotic road trip.', 'Comedy', 'Hindi', 125, 'assets/images/poster5.jpg', '2026-09-01', 6.8, 'coming_soon'),
('Ocean''s Deep', 'A deep sea expedition turns into a fight for survival.', 'Adventure, Thriller', 'English', 138, 'assets/images/poster6.jpg', '2026-09-10', 0.0, 'coming_soon');

-- Shows (dates relative — adjust as needed after import; using near-term static dates)
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price_regular, price_premium, price_recliner) VALUES
(1, 1, CURDATE(), '10:00:00', 150, 250, 400),
(1, 1, CURDATE(), '14:00:00', 150, 250, 400),
(1, 2, CURDATE(), '18:30:00', 180, 280, 450),
(1, 3, CURDATE(), '21:00:00', 200, 300, 480),
(2, 1, CURDATE(), '11:00:00', 160, 260, 420),
(2, 2, CURDATE(), '19:00:00', 190, 290, 460),
(2, 4, CURDATE(), '20:30:00', 170, 270, 430),
(3, 3, CURDATE(), '15:00:00', 150, 240, 400),
(4, 2, CURDATE(), '22:00:00', 180, 280, 440),
(1, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '10:00:00', 150, 250, 400),
(2, 3, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '17:00:00', 190, 290, 460),
(1, 5, CURDATE(), '12:00:00', 160, 260, 420),
(2, 6, CURDATE(), '19:30:00', 170, 270, 430),
(3, 7, CURDATE(), '16:00:00', 150, 240, 400),
(4, 8, CURDATE(), '20:00:00', 180, 280, 440),
(1, 9, CURDATE(), '13:30:00', 150, 250, 400),
(2, 10, CURDATE(), '18:00:00', 190, 290, 460),
(3, 11, CURDATE(), '21:30:00', 160, 250, 410);
