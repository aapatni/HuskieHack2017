<require-login>
  <virtual if="{ loggedIn }">
    <yield></yield>
  </virtual>
  <section if="{ !loggedIn }" class="section">
    <div class="container">
      <h1 class="title">Please login to access this page</h1>
      <h2 class="subtitle">
        If your email is not authorized please contact the troop quartermaster.
      </h2>
    </div>
  </section>
  <auth ref="auth" if="{ !loggedIn }"></auth>
  <script>
    this.on('route', (pram) => {
      for (const tag in this.tags) {
        if (this.tags.hasOwnProperty(tag)) {
          this.tags[tag].trigger('route', pram)
        }
      }
    })
  </script>
</require-login>
