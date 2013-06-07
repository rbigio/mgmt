class IssuesController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources
  respond_to :json
  action :update

  def log_worked_hours
    issue = Issue.find(params[:id])
    logger = WorkedHoursLogger.new(current_user)
    logger.log_worked_hours(params[:worked_hours], issue)
    render json: {}, status: 200
  end

  def update
    issue = Issue.find(params[:id])
    if HandleGithubIssueUpdateContext.new(current_user.github, issue,params[:issue]).handle_issue
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end 
  end
    
  private

    def resource_params
      [] if request.get?
      [params.require(:issue).permit(:estimated_hours, :issue_type, :status)]
    end

end
