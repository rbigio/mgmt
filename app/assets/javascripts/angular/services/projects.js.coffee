services = angular.module('mgmt.services')

services.factory('Projects', (GithubRestangular) ->
  () ->
    GithubRestangular.one('orgs', window.mgmt.organization).all('repos').getList().then((projects) ->
      _.map(projects, (p) ->
        name: p.name,
        type: if p.private then 'private' else 'public'
      )
    )
)

services.factory('Project', (Restangular, GithubRestangular, $route) ->
  () ->
    fetchProject = () -> Restangular.one('projects', $route.current.params.name).get({organization: window.mgmt.organization})
    fetchMilestones = (project) -> GithubRestangular.one('repos', window.mgmt.organization).all(project.name + '/milestones').getList()
    fetchIssues = (project) -> GithubRestangular.one('repos', window.mgmt.organization).all(project.name + '/issues').getList()

    groupIssues = (project) ->
      result = _.groupBy(project.issues, (i) -> i.number)
      delete project.issues
      result

    includeMilestones = (project, milestones) ->
      milestones = _.groupBy(milestones, (m) -> m.number)
      project.milestones = _.map(project.milestones, (m) -> milestones[m.number][0])
      project.milestones.push({title: 'Unassigned', number: -1, issues: []})
      project.currentMilestone = milestones[project.currentMilestone.number][0]
      project

    fillMilestonesWithIssues = (project, issues, issuesByNumber) ->
      issues = _.groupBy(issues, (i) -> if i.milestone then i.milestone.number else '-1')
      _.each(project.milestones, (m) ->
        m.issues = _.map(issues[m.number], (i) -> $.extend(i, issuesByNumber[i.number][0]))
      )
      project

    fetchProject().then((project) ->
      issuesByNumber = groupIssues(project)
      fetchMilestones(project).then((milestones) ->
        includeMilestones(project, milestones)
      ).then((project) ->
        fetchIssues(project).then((issues) ->
          fillMilestonesWithIssues(project, issues, issuesByNumber)
        )
      )
    )
)

