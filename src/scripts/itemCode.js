import pouchdb from '../pouchdb'
import route from 'riot-route'

const items = pouchdb('items')

module.exports = async(itemCode) => {
  let item = await items.find({
    selector: {
      code: itemCode
    }
  })
  item = item.docs[0]
  if (item) {
    route(`/scan/${item._id}`)
  } else {
    route(`/scan/${itemCode}`)
  }
}
