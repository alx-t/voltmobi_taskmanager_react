#

@TaskForm = React.createClass
  displayName: 'TaskForm'

  getInitialState: ->
    name: ''
    description: ''

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    self = this
    $.ajax '',
      type: 'POST'
      data: { task: @state }
      success: (data) ->
        window.ee.emit('Tasks.add', data)
        self.setState self.getInitialState()
      error: ->
        alert 'ajax failure'
    , 'JSON'

  valid: ->
    @state.name && @state.description

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Name'
          name: 'name'
          value: @state.name
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Description'
          name: 'description'
          value: @state.description
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create task'

