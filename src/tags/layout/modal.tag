<modal>
  <div each="{ modals }" class="modal { is-active: open }">
    <div class="modal-background" onclick="{ close }"></div>
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">{ title }</p>
        <button class="delete" onclick="{ close }"></button>
      </header>
      <section class="modal-card-body">
        <virtual data-is="{ body }"></virtual>
      </section>
      <footer class="modal-card-foot">
        <button class="button is-success" onclick="{ close }">Save</button>
        <button class="button" onclick="{ close }">Cancel</button>
      </footer>
    </div>
  </div>
  <script>
    this.open = false
    this.modals = []

    this.close = (event) => {
      this.modals = this.modals.filter((item) => {
        if (event.item == item) {
          item.reject('closed')
          return false
        }
        return true
      })
    }

    this.complete = (event) => {
      this.modals = this.modals.filter((item) => {
        if (event.item == item) {
          item.resolve('saved')
          return false
        }
        return true
      })
    }

    this.openNew = (opts) => {
      return new Promise((resolve, reject) => {
        this.modals.push({
          ...{
            open: true,
            resolve,
            reject
          },
          ...opts
        })
        this.open = true
        this.update()
      })
    }
  </script>
</modal>
