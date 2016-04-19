#

SelectUsers = React.createClass
  getInitialState: ->
    options: []
    selectedUserId: undefined

  componentDidMount: ->
    $.get
      url: '/admin/users'
      success: @successHandler

  successHandler: (data) ->
    self = this
    user = $.grep data, (e) -> e.email == self.props.selectedValue
    @setState selectedUserId: user[0].id
    @setState options: data

  handleChange: (e) ->
    @setState selectedUserId: e.target.value
    @props.changeUserHandler e.target.value

  render: ->
    React.DOM.select
      className: 'form-control'
      value: @state.selectedUserId
      onChange: @handleChange
      React.DOM.option(value: user.id, key: user.id, user.email) for user in @state.options

@Task = React.createClass
  displayName: 'Task'

  contextTypes:
    user_id: React.PropTypes.number
    type: React.PropTypes.string

  getInitialState: ->
    edit: false
    selectedUserId: undefined

  handleChangeUser: (userId) ->
    @setState selectedUserId: userId

  handleDelete: (e) ->
    e.preventDefault(e)
    $.ajax
      method: 'DELETE'
      url: window.type(@context.type).link + "#{ @props.task.id }"
      dataType: 'JSON'
      success: () =>
        window.ee.emit('Tasks.delete', @props.task)

  handleToggle: (e) ->
    e.preventDefault
    @setState edit: !@state.edit

  handleEdit: (e) ->
    e.preventDefault
    data =
      name: ReactDOM.findDOMNode(@refs.name).value
      description: ReactDOM.findDOMNode(@refs.description).value
      user_id: @state.selectedUserId
    $.ajax
      method: 'PATCH'
      url: window.type(@context.type).link + "#{ @props.task.id }"
      dataType: 'JSON'
      data:
        task: data
      success: (data) =>
        @setState edit: false
        window.ee.emit('Tasks.update', @props.task, data)

  taskRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.id
      React.DOM.td null, (new Date(Date.parse(@props.task.task_created_at))).toLocaleString("ru")
      React.DOM.td null, @props.task.name
      for cell in window.type(@context.type).cells
        React.DOM.td {key: cell}, @props.task[cell]
      if @context.user_id
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            onClick: @handleToggle
            'Edit'
          React.DOM.a
            className: 'btn btn-danger'
            onClick: @handleDelete
            'Delete'

  taskForm: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.id
      React.DOM.td null, (new Date(Date.parse(@props.task.task_created_at))).toLocaleString("ru")
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.task.name
          ref: 'name'
      for cell in window.type(@context.type).cells
        React.DOM.td {key: cell},
          switch cell
            when 'description'
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.task[cell]
                ref: cell
            when 'user_email'
              React.createElement SelectUsers, changeUserHandler: @handleChangeUser, selectedValue: @props.task.user_email
            else
              @props.task[cell]
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @taskForm()
    else
      @taskRow()
  
