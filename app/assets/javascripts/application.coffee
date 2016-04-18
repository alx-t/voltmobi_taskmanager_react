#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require react
#= require react_ujs
#= require EventEmitter
#= require components
#= require_tree .

window.ee = new EventEmitter

window.type = (user_type) ->
  {
    'common': {
      titles: ['User'],
      cells: ['user_email'],
      link: ''
    },
    'user': {
      titles: ['Description', 'Status'],
      cells: ['description', 'state'],
      link: '/members/tasks/'
    },
    'admin': {
      titles: ['User', 'Description', 'Status'],
      cells: ['user_email', 'description', 'state'],
      link: '/admin/tasks/'
    }
  }[user_type]

