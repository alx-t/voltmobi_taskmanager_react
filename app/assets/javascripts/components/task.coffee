#

CommonTask = React.createClass
  displayName: 'CommonTask'

  handleDelete: (e) ->
    e.preventDefault(e)
    $.ajax
      method: 'DELETE'
      url: "/members/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      success: () =>
        window.ee.emit('Tasks.delete', @props.task)

  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.id
      React.DOM.td null, (new Date(Date.parse(@props.task.task_created_at))).toLocaleString("ru")
      React.DOM.td null, @props.task.name
      for cell in @props.cells
        React.DOM.td {key: cell}, @props.task[cell]
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  
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

