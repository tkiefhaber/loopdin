class VersionsController < ApplicationController
  before_filter :find_user
  before_filter :find_project

  def new
    @version = Version.new(project: @project)
  end

  def create
    version = Version.new(project_id: params[:project_id], title: params[:version][:title], description: params[:version][:description])
    if version.save
      flash[:notice] = "new version added"
      redirect_to user_project_path(@user, @project)
    else
      flash[:warning] = "something went wrong, try again"
      redirect_to back
    end

  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
