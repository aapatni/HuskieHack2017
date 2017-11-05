<dataTable>
  <div class="mdl-grid">
    <div class="mdl-cell mdl-cell--8-col mdl-cell--2-offset-desktop">
      <div class="mdl-grid">
        <div class="mdl-cell mdl-cell--10-col mdl-cell--3-col-phone">
          <h4>{ opts.title || "Error: No title" }</h4>
        </div>
        <div if={ opts.add } class="mdl-cell mdl-cell--2-col mdl-cell--1-col-phone mdl-cell--1-col-tablet">
          <button onclick={ add } class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
            <i class="material-icons">add</i>
          </button>
        </div>
      </div>
      <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp" if={ tableData && tableData.length}>
        <thead>
          <tr>
            <th each="{ opts.tableheaders }" class="mdl-data-table__cell--non-numeric">{ name }</th>
            <th class="mdl-data-table__cell--non-numeric"></th>
          </tr>
        </thead>
        <tbody>
          <tr each="{ tableData }" if="{ doc._id[0] != '_' }">
            <td each="{ this.parent.opts.tableheaders }" class="mdl-data-table__cell--non-numeric">{ this.parent.doc[value] }</td>
            <td class="mdl-data-table__cell--non-numeric">
              <button onclick={this.parent.edit} class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent">
                Edit
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <script>
    import pouchdb from '../../pouchdb'
    let changeobj
    const changes = async(database) => {
      changeobj = database.changes({since: 'now', live: true}).on('change', async() => {
        const allDocs = await database.allDocs({include_docs: true})
        this.tableData = allDocs.rows
        this.update()
      })
    }
    this.on('mount', async() => {
      const database = pouchdb(this.opts.database)
      this.add = () => {
        this.opts.add(database)
      }
      this.edit = (e) => {
        this.opts.edit(e, database)
      }
      let allDocs
      try {
        allDocs = await database.allDocs({include_docs: true})
      } catch (e) {
        this.toast({message: e.message})
      }
      if (allDocs) {
        this.tableData = allDocs.rows
        this.update()
      }
      changes(database)
    })

    this.on('unmount', async() => {
      changeobj.cancel()
    })
  </script>
</dataTable>
