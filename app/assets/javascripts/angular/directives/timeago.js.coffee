module = angular.module('mgmt.directives')

module.filter('timeago', ->
  (date) -> $.timeago(date)
)