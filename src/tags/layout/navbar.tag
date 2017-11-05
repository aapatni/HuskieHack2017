<navbar>
  <nav class="fixed-nav is-unselectable navbar is-dark">
    <div class="navbar-brand">
      <a href="/" class="navbar-item">Disaster Planning</a>
      <button class="button navbar-burger is-dark" onclick="{ this.parent.openNav }">
        <span></span>
        <span></span>
        <span></span>
      </button>
    </div>

  <div class="navbar-menu is-hidden-touch">
    <div class="navbar-start">
      <div class="navbar-end">
        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link">
            About Us
          </a>
          <div class="navbar-dropdown">
            <a class="navbar-item" href="/contact">
              Contact Us
            </a>
            <a class="navbar-item">
              Directions
            </a>
            <a class="navbar-item" href="/about">
              About Us
            </a>
          </div>
        </div>
        <div class="navbar-item has-dropdown is-hoverable" if="{ loggedIn }">
          <a class="navbar-link">
            Administrator
          </a>
          <div class="navbar-dropdown">
            <a class="navbar-item" href="/admin/pages">
              Pages
            </a>
            <a class="navbar-item" href="/admin/files">
              Files
            </a>
            <a class="navbar-item" href="/admin/editMenu">
              Edit Menu
            </a>
            <a class="navbar-item" href="/admin/settings">
              Settings
            </a>
          </div>
        </div>
      </div>
    </div>
  </nav>
</navbar>
