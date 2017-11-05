import PouchDB from 'pouchdb-browser'
import PouchdbFind from 'pouchdb-find'
const config = require('mainConfig')
PouchDB.plugin(PouchdbFind)
PouchDB.plugin(require('pouchdb-authentication'))

// /**
//  * sync db from server to browser
//  * @param  {String} db name for db to sync
//  * @return {Null} Nothing
//  */
// const replicate = (db) => {
//   PouchDB.sync(db, config.domains.couchdb + db, {
//     live: true,
//     retry: true,
//     timeout: false,
//     heartbeat: 60000
//   })
// }

module.exports = (db) => {
  return new PouchDB(config.domains.couchdb + db)
}
