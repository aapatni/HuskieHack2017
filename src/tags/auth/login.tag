<login>
  <div class="box">
    <span class="is-size-4">Login</span>
    <form onsubmit="{ login }">
      <email ref="username" title="Email"></email>
      <br>
      <password ref="password" title="Password"></password>
      <br>
      <div class="control">
        <button class="button is-primary">Login</button>
      </div>
    </form>
  </div>
  <script>
    import pouchdb from '../../pouchdb'

    const userdb = pouchdb('_users')
    this.register = async(event) => {
      event.preventDefault()
      let user
      try {
        user = await userdb.signup(this.refs.username.value, this.refs.password.value)
      } catch (e) {
        this.toast({title: 'Error', message: e.message, color: 'red', icon: 'fa fa-exclamation'})
      }
      if (user) {
        this.login()
      }
    }

    this.login = async(event) => {
      event.preventDefault()
      let user
      try {
        user = await userdb.login(this.refs.username.value, this.refs.password.value)
      } catch (e) {
        this.toast({title: 'Error', message: e.message, color: 'red', icon: 'fa fa-exclamation'})
      }
      if (user) {
        this.toast({title: 'Welcome', message: user.name, color: 'green', icon: 'fa fa-smile-o'})
        this.loginEvents.loginState = true
        this.loginEvents.trigger('login')
        window.history.back()
      }
    }
  </script>
</login>
