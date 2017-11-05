<home>
  <div class="fullscreen-bg" ref="fullscreenBg"></div>
  <div class="hero-body">
    <p class="title is-1 light-text">
      Welcome to Disaster Planning
    </p>
    <p if="{ likelyDisaster && disasterPrecent }" class="subtitle is-3 light-text">
      Disaster type { likelyDisaster }: { Math.floor(disasterPrecent*100) }% chance in the current month.
    </p>
  </div>
  <iframe
    if="{ destAddr }"
    width="100%"
    height="300"
    frameborder="0"
    style="border:0"
    src="https://www.google.com/maps/embed/v1/directions?key=AIzaSyCeaz5aTPsAE6scO8-gv4rb2FBR6iCHX7M&origin={ position.coords.latitude },{ position.coords.longitude }&destination={ destAddr }&mode=walking"
    allowfullscreen></iframe>
  <script>
    import socketIoClient from 'socket.io-client'
    const io = socketIoClient('https://localhost:8081')
    this.video = require('cloudinary-loader?name=347714086_l1cofg,video=true,autoplay=true,loop=true,controls=false,audio_codec=none!')
    this.appLogo = require('cloudinary-loader?name=rain-2192523_h1428z!')
    this.eagleScout = require('cloudinary-loader?name=rain-2192523_h1428z!')
    this.mapImage = require('../../public/staticmap.jpeg')
    this.on('mount', () => {
      this.refs.fullscreenBg.innerHTML = this.refs.fullscreenBg.innerHTML + this.video
      navigator.geolocation.getCurrentPosition((position) => {
        console.log(position.coords.latitude, position.coords.longitude)
        io.emit('getData', {
          lat: position.coords.latitude,
          lon: position.coords.longitude
        }, (data) => {
          this.destAddr = data.address
          delete data.address
          delete data.hurricane
          this.disasterPrecent = 0
          // const yes = {}
          // for (const disaster in data) {
          //   if (data.hasOwnProperty(disaster)) {
          //     if (Number(data[disaster].yes)) {
          //       yes.disasterPrecent = Number(data[disaster].precent)
          //       yes.likelyDisaster = disaster
          //     }
          //   }
          // }
          // if (yes.likelyDisaster) {
          //   this.disasterPrecent = yes.disasterPrecent
          //   this.likelyDisaster = yes.likelyDisaster
          // } else {
          //   for (const disaster in data) {
          //     if (data.hasOwnProperty(disaster)) {
          //       if (Number(data[disaster]) > this.disasterPrecent) {
          //         this.disasterPrecent = Number(data[disaster].precent)
          //         this.likelyDisaster = disaster
          //       }
          //     }
          //   }
          // }
          for (const disaster in data) {
            if (data.hasOwnProperty(disaster)) {
              console.log(this.disasterPrecent)
              if (Number(data[disaster].precent) > this.disasterPrecent) {
                this.disasterPrecent = Number(data[disaster].precent)
                this.likelyDisaster = disaster
              }
            }
          }
          console.log(this)
          this.update()
        })
        this.position = position
        this.update()
      })
    })
  </script>
</home>
