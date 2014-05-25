class ProjectsController < ApplicationController
  before_filter :find_user

  def index
    @projects = @user.projects.send(user_filter)
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
      assign_collaborators(project)
      flash[:notice] = "new project created"
      redirect_to root_path
    else
      flash[:warning] = "something went wrong, try again"
      redirect_to back
    end

  end

  private

  def user_filter
    case project_params[:filter]
    when 'in_progress' then :in_progress
    when 'collabos'    then :collabos
    when 'approved'    then :approved
    else :all
    end
  end

  def assign_collaborators(project)
    params[:collaboration][:user].split(',').each do |c|
      Collaboration.create(project_id: project.id, user_id: User.find_by_username(c).id)
    end
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def project_params
    params.permit(:filter)
  end
end
