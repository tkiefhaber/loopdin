class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
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
end
