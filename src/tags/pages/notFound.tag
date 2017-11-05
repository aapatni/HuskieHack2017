<notFound>
  <div class="sk-wave" if="{ loading }">
    <div class="sk-rect sk-rect1"></div>
    <div class="sk-rect sk-rect2"></div>
    <div class="sk-rect sk-rect3"></div>
    <div class="sk-rect sk-rect4"></div>
    <div class="sk-rect sk-rect5"></div>
  </div>
  <!-- Not found -->
  <h1 class="title light-text" if="{ !found }">{ name }: Page Not Found</h1>
  <a class="button is-link is-outlined" if="{ loggedIn && !found }" href="/admin/createPage/{ name }">Create Page: { name }</a>
  <!-- Page if found -->
  <h1 class="title light-text" ref="title" if="{ found }"></h1>
  <div class="content light-text" ref="content" data-editable data-name="content" if="{ found }"></div>
  <a class="is-link is-outlined" if="{ loggedIn && found }" onclick="{ edit }" if="{ found }">Edit Page</a>
  <script>
    import pouchdb from '../../pouchdb'
    const pages = pouchdb('pages')

    this.loading = true
    this.found = true

    this.edit = async() => {
      const ContentTools = await import('ContentTools')
      console.log(ContentTools)
      ContentTools.StylePalette.add([
        new ContentTools.Style('Title', 'title', [
          'p',
          'h1',
          'h2',
          'h3',
          'h4',
          'h5'
        ]),
        new ContentTools.Style('Subtitle', 'subtitle', [
          'p',
          'h1',
          'h2',
          'h3',
          'h4',
          'h5'
        ])
      ])
      this.editor = ContentTools.EditorApp.get()
      this.editor.init('*[data-editable]', 'data-name')
      this.editor.addEventListener('saved', (ev) => {
        const regions = ev.detail().regions
        this.page.HTML = regions.content
        pages.put(this.page)
        console.log(regions)
      })
    }

    this.on('unmount', () => {
      if (this.editor) {
        this.editor.destroy()
      }
    })

    this.on('route', async(pageName) => {
      this.loading = true
      this.found = true
      this.update()
      this.name = pageName
      this.page = await pages.find({
        selector: {
          name: pageName
        }
      })
      this.page = this.page.docs[0]
      if (this.page) {
        this.refs.title.innerHTML = this.page.title
        this.refs.content.innerHTML = this.page.HTML
        this.found = true
        this.loading = false
        this.update()
      } else {
        this.found = false
        this.loading = false
        this.update()
      }
    })
  </script>
</notFound>
