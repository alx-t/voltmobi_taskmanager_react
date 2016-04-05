# 

CommonTitle = React.createClass
  getDefaultProps: ->
    titles: ['User']

  render: ->
    React.DOM.thead null,
      React.DOM.tr null,
        React.DOM.th null, 'ID'
        React.DOM.th null, 'Created at'
        React.DOM.th null, 'Name'
        for title in @props.titles
          React.DOM.th {key: title}, title

@Tasks = React.createClass
  getDefaultProps: ->
    tasks: []
    type: 'common'

  commonTitle: ->
    React.createElement(CommonTitle, titles: ['User'])

  userTitle: ->
    React.createElement(CommonTitle, titles: ['Description', 'Status'])
  
  adminTitle: ->
    React.createElement(CommonTitle, titles: ['User', 'Description', 'Status'])

  renderTitle: ->
    switch @props.type
      when 'common' then @commonTitle() 
      when 'user' then @userTitle()
      when 'admin' then @adminTitle()

  render: ->
    React.DOM.div
      className: 'tasks'
      React.DOM.h2
        className: 'title'
        'Tasks'
      React.DOM.table
        className: 'table table-bordered'
        @renderTitle()
        React.DOM.tbody null,
          for task in @props.tasks
            React.createElement Task, key: task.id, task: task, type: @props.type

