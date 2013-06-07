class MilestonesController < ApplicationController
  before_filter :authenticate_user!
  #inherit_resources
  action :update

  def update
    @project = Project.find(params[:project_id])
    if @project.update_attributes(resource_params)
      flash[:notice]=t('views.milestones.update.succeed')
    else
      flash[:error]=t('views.milestones.update.failed')
    end
    redirect_to settings_project_url(@project.name)
  end
  
  private

    def resource_params
      [] if request.get?
      params.require(:project).permit(:milestones_attributes => [:id, :start_date, :estimated_hours, :client_estimated_hours])
    end

end