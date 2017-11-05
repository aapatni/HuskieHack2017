<tabs>
  <div class="tabs is-centered">
    <ul>
      <li each="{ tabs }" class="{ is-active: active }">
        <a onclick="{ tabClick }">{ title }</a>
      </li>
    </ul>
  </div>
  <yield/>
  <script>
  this.tabs = []

  this.on('mount', () => {
    for (const tag in this.tags) {
      if (this.tags.hasOwnProperty(tag)) {
        if (Array.isArray(this.tags[tag])) {
          for (const tabTag in this.tags[tag]) {
            if (this.tags[tag].hasOwnProperty(tabTag)) {
              this.tabs.push({
                tag: this.tags[tag][tabTag],
                title: this.tags[tag][tabTag].opts.title,
                active: false
              })
            }
          }
        } else {
          this.tabs.push({
            tag: this.tags[tag],
            title: this.tags[tag].opts.title,
            active: false
          })
        }
      }
    }
    this.tabs[0].active = true
    this.tabs[0].tag.active = true
    this.tabs[0].tag.back = false
    this.tabs[this.tabs.length - 1].tag.next = false
    this.update()
  })

  this.tabClick = (event) => {
    this.tabSelect(event.item)
  }

  this.tabSelect = async(tab) => {
    tab.active = true
    tab.tag.active = true
    this.tabs = await Promise.all(this.tabs.map(async(item) => {
      if (item != tab) {
        item.tag.active = false
        item.active = false
        return item
      }
      return item
    }))
    this.update()
  }
  </script>
</tabs>
