<?php
$base = '';
$page_title = 'Sign In';
require_once __DIR__ . '/includes/bootstrap.php';

if (is_logged_in()) redirect('index.php');

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['user_name'] = $user['name'];
        $_SESSION['role'] = $user['role'];

        $redirect_to = $_SESSION['redirect_after_login'] ?? 'index.php';
        unset($_SESSION['redirect_after_login']);
        redirect($redirect_to);
    } else {
        $error = 'Invalid email or password.';
    }
}

require_once __DIR__ . '/includes/header.php';
?>

<div class="form-card">
    <h2>Sign In</h2>
    <?php if ($error): ?>
        <div class="alert alert-error"><?= e($error) ?></div>
    <?php endif; ?>
    <form method="POST">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" value="<?= e($_POST['email'] ?? '') ?>" required autofocus>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-block">Sign In</button>
    </form>
    <div class="form-footer">New here? <a href="register.php" style="color:#d2232a; font-weight:600;">Create an account</a></div>
    <p style="font-size:12px; text-align:center; color:#999; margin-top:14px;">
        Admin demo: admin@bms.com / admin123
    </p>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
