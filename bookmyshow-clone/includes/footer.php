</main>

<footer class="site-footer">
    <div class="footer-inner">
        <p>&copy; <?= date('Y') ?> ShowTime Clone Project — Built with PHP &amp; MySQL for learning purposes.</p>
        <p class="footer-note">This is a demo project inspired by BookMyShow's UX. Not affiliated with BookMyShow.</p>
    </div>
</footer>

<script>
(function () {
    var trigger   = document.getElementById('cityTrigger');
    var overlay   = document.getElementById('cityModalOverlay');
    var closeBtn  = document.getElementById('cityModalClose');
    var searchBox = document.getElementById('citySearchInput');
    var popularGroup = document.getElementById('popularCityGroup');
    var allGroup      = document.getElementById('allCityGroup');
    var noResults     = document.getElementById('cityNoResults');

    function openModal() {
        overlay.classList.add('open');
        document.body.style.overflow = 'hidden';
        searchBox.value = '';
        filterCities('');
        setTimeout(function () { searchBox.focus(); }, 50);
    }
    function closeModal() {
        overlay.classList.remove('open');
        document.body.style.overflow = '';
    }

    trigger.addEventListener('click', openModal);
    closeBtn.addEventListener('click', closeModal);
    overlay.addEventListener('click', function (e) {
        if (e.target === overlay) closeModal();
    });
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeModal();
    });

    function filterCities(query) {
        query = query.trim().toLowerCase();
        var anyVisible = false;

        document.querySelectorAll('.city-list-item').forEach(function (el) {
            var match = el.dataset.city.toLowerCase().indexOf(query) !== -1;
            el.style.display = match ? '' : 'none';
            if (match) anyVisible = true;
        });

        // Hide the "Popular" section while actively searching to avoid duplicates
        popularGroup.style.display = query === '' ? '' : 'none';
        noResults.style.display = anyVisible ? 'none' : '';
    }

    searchBox.addEventListener('input', function () {
        filterCities(this.value);
    });

    function selectCity(city) {
        var url = window.SHOWTIME_BASE + 'set_city.php?city=' + encodeURIComponent(city);
        window.location.href = url;
    }

    document.querySelectorAll('.city-chip, .city-list-item').forEach(function (el) {
        el.addEventListener('click', function () {
            selectCity(this.dataset.city);
        });
    });
})();

// Subtle elevated shadow on the navbar once the page scrolls
(function () {
    var nav = document.querySelector('.navbar');
    if (!nav) return;
    window.addEventListener('scroll', function () {
        if (window.scrollY > 6) nav.classList.add('scrolled');
        else nav.classList.remove('scrolled');
    });
})();
</script>

</body>
</html>
