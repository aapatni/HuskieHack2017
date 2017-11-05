<home>
  <div class="fullscreen-bg" ref="fullscreenBg"></div>
  <div class="hero-body">
    <p class="title is-1 light-text">
      Welcome to Disaster Planning
    </p>
    <p class="subtitle is-3 light-text">
      { position.coords.latitude },{ position.coords.longitude }
    </p>
  </div>
  <div class="columns is-multiline">
    <div class="column is-one-quarter">
      <div class="card transparent">
        <div class="card-image">
          <figure class="image">
            <img src="{ appLogo }">
          </figure>
        </div>
        <div class="card-content">
          <div class="content">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
            dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          </div>
        </div>
      </div>
    </div>
    <div class="column is-one-quarter">
      <div class="card transparent">
        <div class="card-image">
          <figure class="image">
            <img src="{ mapImage }" alt="Knox Presbyterian Church Map">
          </figure>
        </div>
        <div class="card-content">
          <div class="content">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
            dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          </div>
        </div>
      </div>
    </div>
    <div class="column is-one-quarter">
      <div class="card transparent">
        <div class="card-image">
          <figure class="image">
            <img src="{ eagleScout }">
          </figure>
        </div>
        <div class="card-content">
          <div class="content">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
            dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          </div>
        </div>
      </div>
    </div>
    <div class="column is-one-quarter">
      Fourth column
    </div>
  </div>
  <script>
    this.video = require('cloudinary-loader?name=347714086_l1cofg,video=true,autoplay=true,loop=true,controls=false,audio_codec=none!')
    this.appLogo = require('cloudinary-loader?name=rain-2192523_h1428z!')
    this.eagleScout = require('cloudinary-loader?name=rain-2192523_h1428z!')
    this.mapImage = require('../../public/staticmap.jpeg')
    this.on('mount', () => {
      this.refs.fullscreenBg.innerHTML = this.refs.fullscreenBg.innerHTML + this.video
      navigator.geolocation.getCurrentPosition((position) => {
        console.log(position.coords.latitude, position.coords.longitude)
        this.position = position
        this.update()
      })
    })
  </script>
</home>
