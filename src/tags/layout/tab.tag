<tab show="{ active }" class="animated slideInDown">
  <yield/>
  <a class="button is-warning" if="{ back }" onclick="{ goBack }">
    <span class="icon is-small">
      <i class="material-icons">arrow_back</i>
    </span>
    <span>Back</span>
  </a>
  <a class="button is-success is-outlined" if="{ next }" onclick="{ goNext }">
    <span>Next</span>
    <span class="icon is-small">
      <i class="material-icons">arrow_forward</i>
    </span>
  </a>
  <script>
    this.active = false
    this.next = true
    this.back = true

    this.goBack = () => {
      this.parent.tabs.forEach((item, index) => {
        if (item.tag == this) {
          this.parent.tabSelect(this.parent.tabs[index - 1])
        }
      })
    }

    this.goNext = () => {
      this.parent.tabs.forEach((item, index) => {
        if (item.tag == this) {
          this.parent.tabSelect(this.parent.tabs[index + 1])
        }
      })
    }
  </script>
</tab>
