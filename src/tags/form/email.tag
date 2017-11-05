<email>
  <div class="field">
    <div class="field-body">
      <div class="field">
        <p class="control has-icons-left">
          <input ref="input" autocomplete="email" onchange="{ updateValue }" class="input" type="email" placeholder="{ opts.title }" disabled="{ opts.disabled }" required="{ opts.required }">
          <span class="icon is-small is-left">
            <i class="material-icons">email</i>
          </span>
        </p>
      </div>
    </div>
  </div>
  <script>
    this.on('mount', () => {
      if (this.opts.riotValue) {
        this.value = this.opts.riotValue
        const input = this.refs.input
        input.value = this.value
      }
    })

    this.updateValue = async(event) => {
      if (this.opts.onChange) {
        this.opts.onChange(event)
      }
      this.value = event.target.value
    }
  </script>
</email>
