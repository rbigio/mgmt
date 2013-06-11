angular.module('mgmt.directives', [])
  .directive('mgmtProjects', () ->
    restrict: 'E',
    templateUrl: '/assets/projects/_projects.html',
    scope:
      projects: '=items'
  )
