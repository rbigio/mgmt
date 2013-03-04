class RepositoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @repo = repository
    unless @repo
      @repo = Github::Repository.new(current_user.github, create_repository)
      @repo.from_github!
    end
  end

  private

    def repository_attributes
      {
        organization: organization_name,
        name: params[:id]
      }
    end

    def repository
      Repository.where(repository_attributes).first
    end

    def create_repository
      Repository.create!(repository_attributes)
    end

end