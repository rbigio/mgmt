module = angular.module('mgmt.directives')

module.directive('mgmtProjects', () ->
  restrict: 'E',
  templateUrl: '/assets/projects/_projects.html',
  scope:
    projects: '=items'
)
