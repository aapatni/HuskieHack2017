import riot from 'riot'
import route from 'riot-route'
import pouchdb from './pouchdb'
import izitoast from 'izitoast'

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

/**
 * hotjar tracking code
 * @param  {Object} h window
 * @param  {Object} o document
 * @param  {String} t String
 * @param  {String} j String
 * @param  {undefined} a undefined
 * @param  {undefined} r undefined
 * @return {undefined}   undefined
 */
const hotjar = (h,o,t,j,a,r) => {
  h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)}
  h._hjSettings={hjid:670441,hjsv:6}
  a=o.getElementsByTagName('head')[0]
  r=o.createElement('script');r.async=1
  r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv
  a.appendChild(r)
}
hotjar(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=')

const userdb = pouchdb('_users')

const loginEvents = riot.observable({
  loginState: null
})

const mixinObject = {
  init () {
    this.loggedIn = this.loginEvents.loginState
    this.loginEvents.on('login', async() => {
      const tracker = Piwik.getTracker('https://piwik.pixelcubed.net/piwik.php', '1')
      tracker.setUserId(loginEvents.username)
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

/**
 * set piwik settings
 * @return {undefined}
 */
const piwik = () => {
  Piwik.addTracker()
  _paq.push(['setTrackerUrl', '//piwik.pixelcubed.net/piwik.php'])
  _paq.push(['setSiteId', '1'])
  _paq.push(['setCookieDomain', '*.troop505.org'])
  _paq.push(['setDomains', ['*.troop505.org']])
  _paq.push(['trackPageView'])
  _paq.push(['enableLinkTracking'])
}

document.addEventListener('DOMContentLoaded', async() => {
  const response = await userdb.getSession()
  const tracker = Piwik.getTracker('https://piwik.pixelcubed.net/piwik.php', '1')
  tracker.enableHeartBeatTimer(5)
  if (response.userCtx.name) {
    loginEvents.loginState = true
    loginEvents.username = response.userCtx.name
    tracker.setUserId(response.userCtx.name)
  }
  piwik()
  route(function() {
    tracker.setCustomUrl(window.location.href)
    tracker.trackPageView(`/${Array.from(arguments).join('/')}`)
  })
  route.base('/')
  riot.mount('app')
  riot.mount('modal')
  removeLoaders()
})
