module = angular.module('mgmt.directives', [])

module.directive('mgmtIssue', () ->
  restrict: 'E',
  templateUrl: '/assets/projects/_issue.html',
  scope:
    title: '@'
    status: '@'
    issueType: '@'
    githubStatus: '@'
    status: '@'
)

module.directive('mgmtProjects', () ->
  restrict: 'E',
  templateUrl: '/assets/projects/_projects.html',
  scope:
    projects: '=items'
)
