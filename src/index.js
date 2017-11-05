import riot from 'riot'
import route from 'riot-route'
import izitoast from 'izitoast'
import runtime from 'serviceworker-webpack-plugin/lib/runtime'

(async () => {if ('serviceWorker' in navigator) {
  const registration = runtime.register()
  console.log(await registration)
}})()

//third party css
require('bulma/bulma.sass')
require('izitoast/dist/css/iziToast.css')
require('spinkit/css/spinkit.css')

//Video Background
require('./public/videoBackground.css')

//custom css
require('./public/sidenav.css')
require('./public/datalist.css')
require('./public/style.css')

//editor
require('./public/dataEditable.css')
require('ContentTools/build/content-tools.min.css')

//tag files
require('./tags')

const loginEvents = riot.observable({
  loginState: null
})

const mixinObject = {
  init () {
    this.loggedIn = this.loginEvents.loginState
    this.loginEvents.on('login', async() => {
      this.loggedIn = true
      this.update()
    })
    this.loginEvents.on('logout', async() => {
      this.loggedIn = false
      this.update()
    })
  },
  toast (data) {
    izitoast.show({...{position: 'bottomRight', close: false, layout: 2, progressBar: true, target: 'navbar'},...data})
  },
  async modal (opts) {
    const tag = document.getElementsByTagName('modal')[0]._tag
    await tag.openNew(opts)
  },
  loginEvents
}
riot.mixin(mixinObject)

/**
 * Remove loading animation
 * @returns {void}
 */
const removeLoaders = () => {
  document.querySelectorAll('.load').forEach((e) => {
    e.remove()
  })
}

document.addEventListener('DOMContentLoaded', async() => {
  route.base('/')
  riot.mount('app')
  riot.mount('modal')
  removeLoaders()
})
