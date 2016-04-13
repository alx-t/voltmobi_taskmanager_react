#

CommonTask = React.createClass
  displayName: 'CommonTask'

  contextTypes:
    user_id: React.PropTypes.number

  getInitialState: ->
    edit: false

  handleDelete: (e) ->
    e.preventDefault(e)
    $.ajax
      method: 'DELETE'
      url: "/members/tasks/#{ @props.task.id }"
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
    $.ajax
      method: 'PATCH'
      url: "/members/tasks/#{ @props.task.id }"
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
      for cell in @props.cells
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
      for cell in @props.cells
        React.DOM.td {key: cell},
          if cell == 'description'
            React.DOM.input
              className: 'form-control'
              type: 'text'
              defaultValue: @props.task[cell]
              ref: cell
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
  
@Task = React.createClass
  displayName: 'Task'

  commonTask: ->
    React.createElement(CommonTask, task: @props.task, cells: ['user_email'])

  userTask: ->
    React.createElement(CommonTask, task: @props.task, cells: ['description', 'state'])

  adminTask: ->
    React.createElement(CommonTask, task: @props.task, cells: ['user_email', 'description', 'state'])

  renderTask: ->
    switch @props.type
      when 'common' then @commonTask()
      when 'user' then @userTask()
      when 'admin' then @adminTask()

  render: ->
    @renderTask()

