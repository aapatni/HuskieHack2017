<footer class="footer">
  <div class="container">
    <div class="content has-text-centered has-text-weight-bold">
      <p>
        Made for Huskie Hack
      </p>
    </div>
    <div class="content has-text-right">
      <a class="button is-link is-outlined" href="/privacyPolicy">Privacy Policy</a>
      <a class="button is-link is-outlined" href="/login" if="{ !loggedIn }">Login</a>
      <button class="button is-link is-outlined" onclick="{ logout }" if="{ loggedIn }">Logout</button>
    </div>
  </div>
</footer>
