# 

CommonTitle = React.createClass
  displayName: 'CommonTitle'

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
        React.DOM.th null, 'Actions'

@Tasks = React.createClass
  displayName: 'Tasks'

  getDefaultProps: ->
    tasks: []
    type: 'common'

  getInitialState: ->
    tasks: @props.tasks
    type: @props.type

  commonTitle: ->
    React.createElement(CommonTitle, titles: ['User'])

  userTitle: ->
    React.createElement(CommonTitle, titles: ['Description', 'Status'])
  
  adminTitle: ->
    React.createElement(CommonTitle, titles: ['User', 'Description', 'Status'])

  componentDidMount: ->
    self = this
    window.ee.addListener 'Tasks.add', (task) ->
      tasks = React.addons.update(self.state.tasks, { $push: [task] })
      self.setState tasks: tasks
    window.ee.addListener 'Tasks.delete', (task) ->
      index = self.state.tasks.indexOf task
      tasks = React.addons.update(self.state.tasks, { $splice: [[index, 1]] })
      self.replaceState tasks: tasks

  componentWillUnmount: ->
    window.ee.removeListener('Tasks.add')
    window.ee.removeListener('Tasks.delete')

  renderTitle: ->
    switch @props.type
      when 'common' then @commonTitle()
      when 'user' then @userTitle()
      when 'admin' then @adminTitle()

  renderForm: ->
    if @props.user_id
      React.createElement(TaskForm)
    else
      return

  render: ->
    React.DOM.div
      className: 'tasks'
      React.DOM.h2
        className: 'title'
        'Tasks'
      @renderForm()
      React.DOM.table
        className: 'table table-bordered'
        @renderTitle()
        React.DOM.tbody null,
          for task in @state.tasks
            React.createElement Task, key: task.id, task: task, type: @props.type

