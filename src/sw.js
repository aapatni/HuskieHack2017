const DEBUG = true

const { assets } = global.serviceWorkerOption

const CACHE_NAME = new Date().toISOString()

let assetsToCache = [...assets, './']

assetsToCache = assetsToCache.map(path => {
  return new URL(path, global.location).toString()
})
console.log(assetsToCache)

// When the service worker is first added to a computer.
self.addEventListener('install', event => {
  // Perform install steps.
  if (DEBUG) {
    console.log('[SW] Install event')
  }

  // Add core website files to cache during serviceworker installation.
  event.waitUntil(
    global.caches
      .open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(assetsToCache)
      })
      .then(() => {
        if (DEBUG) {
          console.log('Cached assets: main', assetsToCache)
        }
      })
      .catch(error => {
        console.error(error)
      })
  )
})

// After the install event.
self.addEventListener('activate', () => {
  if (DEBUG) {
    console.log('[SW] Activate event')
  }
})

self.addEventListener('fetch', event => {
  const request = event.request

  // Ignore not GET request.
  if (request.method !== 'GET') {
    if (DEBUG) {
      console.log(`[SW] Ignore non GET request ${request.method}`)
    }
    return
  }

  const requestUrl = new URL(request.url)

  // Ignore difference origin.
  if (requestUrl.origin !== location.origin) {
    if (DEBUG) {
      console.log(`[SW] Ignore difference origin ${requestUrl.origin}`)
    }
    return
  }

  const resource = global.caches.match(request).then(response => {
    if (response) {
      if (DEBUG) {
        console.log(`[SW] fetch URL ${requestUrl.href} from cache`)
      }

      return response
    }

    // Load and cache known assets.
    return fetch(request)
      .then(responseNetwork => {
        if (!responseNetwork || !responseNetwork.ok) {
          if (DEBUG) {
            console.log(
              `[SW] URL [${requestUrl.toString()}] wrong responseNetwork: ${responseNetwork.status} ${responseNetwork.type}`
            )
          }

          return responseNetwork
        }

        if (DEBUG) {
          console.log(`[SW] URL ${requestUrl.href} fetched`)
        }

        const responseCache = responseNetwork.clone()

        global.caches
          .open(CACHE_NAME)
          .then(cache => {
            return cache.put(request, responseCache)
          })
          .then(() => {
            if (DEBUG) {
              console.log(`[SW] Cache asset: ${requestUrl.href}`)
            }
          })

        return responseNetwork
      })
      .catch(() => {
        // User is landing on our page.
        if (event.request.mode === 'navigate') {
          return global.caches.match('./')
        }

        return null
      })
  })

  event.respondWith(resource)
})
