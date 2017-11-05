<createPage>
  <br>
  <text ref="slug" title="Slug" value="{ slug }"></text>
  <br>
  <text ref="title" title="Title" value="{ title }"></text>
  <br>
  <button class="button is-light" onclick="{ createPage }">Create Page</button>
  <script>
    import pouchdb from '../../../pouchdb.js'
    const pages = pouchdb('pages')

    this.createPage = async() => {
      const testName = await pages.find({
        selector: {
          name: this.refs.slug.value
        }
      })
      if (!testName.docs.length) {
        pages.post({name: this.refs.slug.value, title: this.refs.title.value, HTML: ''})
        window.history.back()
      }
    }

    this.on('route', (pageName) => {
      this.slug = pageName
    })
  </script>
</createPage>
