class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
  end

  def show
    project = Project.where(project_attributes).first
    unless project
      # XXX This should be done async and the web page shoud check
      # against the server to know when the project has been created.
      callback_url = issues_github_notifications_url(organization_name, params[:id])
      project = CreatingNewProjectContext.new({
        user: current_user,
        project_attributes: project_attributes,
        notifications_callback_url: callback_url,
        subscribe_to_events: Rails.application.config.github.subscribe_to_events
      }).create
    end

    result = project.as_json
    result['issues'] = project.issues.as_json
    result['milestones'] = project.milestones.as_json

    render :json => result
  end

  def settings
    @project = Project.where(project_attributes).first
  end

  private

    def project_attributes
      {
        organization: organization_name,
        name: params[:id]
      }
    end

end
