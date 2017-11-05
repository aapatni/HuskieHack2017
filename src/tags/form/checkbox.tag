<checkbox>
  <label class="checkbox">
    <input type="checkbox" onchange="{ updateValue }" disabled="{ opts.disabled }" required="{ opts.required }">
    { opts.title }
  </label>
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
</checkbox>
