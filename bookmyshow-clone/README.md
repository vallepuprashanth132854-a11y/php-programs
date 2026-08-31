# ShowTime — Movie Ticket Booking (BookMyShow-style clone)

A full PHP + MySQL movie ticket booking web app: browse movies, view showtimes across theaters,
pick seats on an interactive seat map, "pay" (simulated), and get an e-ticket. Includes a basic
admin panel to manage movies, theaters, screens, shows, and bookings.

## Tech Stack
- PHP 8+ (plain PHP, PDO for MySQL — no framework required)
- MySQL / MariaDB
- Vanilla JS + CSS (no build step)

## Features
- Browse "Now Showing" / "Coming Soon" movies, search by title
- Movie detail page with showtimes grouped by theater and date
- Interactive seat map (regular / premium / recliner pricing tiers)
- Real-time-safe booking: seat availability is re-checked in a DB transaction at confirmation
  time to prevent double-booking
- Simulated payment flow + e-ticket / booking confirmation page
- User accounts: register, login, "My Bookings" history
- Admin panel: dashboard stats, CRUD for movies/theaters/screens/shows, view & cancel bookings

## Setup

1. **Create the database.** Import the schema and sample data:
   ```bash
   mysql -u root -p < database.sql
   ```
   (Or use phpMyAdmin: create a database, then import `database.sql`.)

2. **Configure the DB connection.** Edit `config/db.php` if your MySQL user/password
   differ from the defaults (`root` / empty password).

3. **Set the admin password.** Open `setup_admin.php` in your browser once
   (e.g. `http://localhost/bookmyshow-clone/setup_admin.php`). This sets the demo
   admin login to:
   - Email: `admin@bms.com`
   - Password: `admin123`

   **Delete `setup_admin.php` after running it once.**

4. **Serve the project.** Point your web server (Apache/Nginx/XAMPP/MAMP/PHP built-in
   server) at the project root. For a quick local test:
   ```bash
   php -S localhost:8000
   ```
   Then visit `http://localhost:8000`.

5. Register a normal account to test the booking flow, or log in as admin to add your
   own movies, theaters, and showtimes.

## Project Structure
```
config/db.php          Database connection
includes/               Shared header/footer/functions
index.php                Homepage — movie listings + search
movie.php                Movie detail + showtimes
seats.php                Seat selection (auto-generates seat layout per screen)
book.php                 Validates selection, stores it in session
payment.php               Simulated payment form
confirm.php               Confirms booking inside a DB transaction
booking_success.php       E-ticket / confirmation page
login.php / register.php / logout.php
my_bookings.php            User's booking history
admin/                     Admin dashboard + management pages
assets/css/style.css        Styling
database.sql                Schema + sample data
setup_admin.php              One-time admin password setup (delete after use)
```

## Notes
- Poster images are simple styled placeholders (movie title on a gradient card) so the
  project runs with zero external assets. Add real image files under `assets/images/`
  and update each movie's `poster_url` to use actual artwork.
- This is an educational clone built for learning purposes and isn't affiliated with
  or endorsed by BookMyShow.
