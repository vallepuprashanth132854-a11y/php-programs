<?php
$base = '';
$page_title = 'Sign Up';
require_once __DIR__ . '/includes/bootstrap.php';

if (is_logged_in()) redirect('index.php');

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $phone = trim($_POST['phone'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirm = $_POST['confirm_password'] ?? '';

    if ($name === '' || $email === '' || $password === '') {
        $errors[] = 'Please fill in all required fields.';
    }
    if ($password !== $confirm) {
        $errors[] = 'Passwords do not match.';
    }
    if (strlen($password) < 6) {
        $errors[] = 'Password must be at least 6 characters.';
    }

    if (empty($errors)) {
        $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
        $stmt->execute([$email]);
        if ($stmt->fetch()) {
            $errors[] = 'An account with this email already exists.';
        }
    }

    if (empty($errors)) {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $pdo->prepare("INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, 'user')");
        $stmt->execute([$name, $email, $phone, $hash]);

        $_SESSION['user_id'] = $pdo->lastInsertId();
        $_SESSION['user_name'] = $name;
        $_SESSION['role'] = 'user';

        flash('success', 'Welcome to ShowTime, ' . $name . '!');
        redirect('index.php');
    }
}

require_once __DIR__ . '/includes/header.php';
?>

<div class="form-card">
    <h2>Create Account</h2>
    <?php foreach ($errors as $err): ?>
        <div class="alert alert-error"><?= e($err) ?></div>
    <?php endforeach; ?>
    <form method="POST">
        <div class="form-group">
            <label>Full Name *</label>
            <input type="text" name="name" value="<?= e($_POST['name'] ?? '') ?>" required>
        </div>
        <div class="form-group">
            <label>Email *</label>
            <input type="email" name="email" value="<?= e($_POST['email'] ?? '') ?>" required>
        </div>
        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" value="<?= e($_POST['phone'] ?? '') ?>">
        </div>
        <div class="form-group">
            <label>Password *</label>
            <input type="password" name="password" required>
        </div>
        <div class="form-group">
            <label>Confirm Password *</label>
            <input type="password" name="confirm_password" required>
        </div>
        <button type="submit" class="btn btn-block">Sign Up</button>
    </form>
    <div class="form-footer">Already have an account? <a href="login.php" style="color:#d2232a; font-weight:600;">Sign In</a></div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
