<footer class="footer">
  <div class="container">
    <div class="content has-text-centered has-text-weight-bold">
      <p>
        Copyright © 2017 Troop 505
      </p>
    </div>
    <div class="content has-text-right">
      <a class="button is-link is-outlined" href="/privacyPolicy">Privacy Policy</a>
      <a class="button is-link is-outlined" href="/login" if="{ !loggedIn }">Login</a>
      <button class="button is-link is-outlined" onclick="{ logout }" if="{ loggedIn }">Logout</button>
    </div>
  </div>
  <script>
    import pouchdb from '../../pouchdb.js'

    const userdb = pouchdb('_users')
    this.logout = async(e) => {
      e.preventDefault()
      await userdb.logout()
      this.loginEvents.loginState = false
      this.loginEvents.trigger('logout')
      this.toast({title: 'Logout Successful', color: 'green'})
    }
  </script>
</footer>
