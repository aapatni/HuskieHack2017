<app>
  <div id="sidenav-backdrop"></div>
  <div id="sidenav-sidenav" class="box">
    <sidenav></sidenav>
  </div>
  <div id="sidenav-content">
    <navbar if="{ sidenav }"></navbar>
    <section class="section main-section">
      <div class="container">
        <br>
        <page-router></page-router>
      </div>
    </section>
    <footer>
    </footer>
  </div>
  <script>
    this.openNav = () => {
      this.sidenav.open()
    }
    this.on('mount', () => {
      const Sidenav = require('../public/sidenav.js')
      this.sidenav = new Sidenav({content: document.getElementById('sidenav-content'), sidenav: document.getElementById('sidenav-sidenav'), backdrop: document.getElementById('sidenav-backdrop')})
      this.update()
    })
  </script>
</app>
