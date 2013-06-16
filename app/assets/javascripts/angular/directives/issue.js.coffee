module = angular.module('mgmt.directives')

module.directive('mgmtIssue', () ->
  restrict: 'E'
  templateUrl: '/assets/projects/_issue.html'
  scope:
    title: '@'
    number: '@'
    status: '@'
    type: '@'
    state: '@'
    status: '@'
    estimatedHours: '@'
    workedHours: '@'
    createdAt: '@'
    updatedAt: '@'
  link: (scope, iElement, iAttrs) ->
    scope.types = ['chore', 'feature', 'bug']
    scope.updateEstimatedHours = () ->
      
)
