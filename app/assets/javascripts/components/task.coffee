#

@Task = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.id
      React.DOM.td null, (new Date(Date.parse(@props.task.created_at))).toLocaleString("ru")
      React.DOM.td null, @props.task.name
      React.DOM.td null, @props.task.user_email

