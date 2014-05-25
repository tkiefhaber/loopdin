class VersionsController < ApplicationController
  before_filter :find_user
  before_filter :find_project

  def new
    @version = Version.new(project: @project)
  end

  def create
    version = Version.new(version_params)
    version.project = @project
    if version.save
      flash[:notice] = "new version added"
      redirect_to user_project_path(@user, @project)
    else
      flash[:warning] = version.errors.full_messages[0]
      redirect_to :back
    end

  end

  private

  def version_params
    params.require(:version).permit(:title, :description, :file, :project_id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
