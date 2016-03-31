# 

@Tasks = React.createClass
  getDefaultProps: ->
    tasks: []

  getInitialState: ->
    tasks: @props.data

  render: ->
    React.DOM.div
      className: 'tasks'
      React.DOM.h2
        className: 'title'
        'Tasks'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'ID'
            React.DOM.th null, 'Created at'
            React.DOM.th null, 'Name'
            React.DOM.th null, 'User'
        React.DOM.tbody null,
          for task in @state.tasks
            React.createElement Task, key: task.id, task: task

