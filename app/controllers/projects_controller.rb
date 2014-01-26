class ProjectsController < ApplicationController
  before_filter :find_user

  def index
    @projects = @user.projects
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new(user: @user)
  end

  def create
    project = Project.new(user_id: params[:user_id], title: params[:project][:title], description: params[:project][:description])
    if project.save
      flash[:notice] = "new project created"
      redirect_to root_path
    else
      flash[:warning] = "something went wrong, try again"
      redirect_to back
    end

  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
