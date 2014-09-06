class ProjectsController < ApplicationController
  before_filter :find_user

  def index
    @projects = @user.all_projects
  end

  def show
    @project = Project.find_by_slug(params[:id])
    unless user_permitted?
      flash[:danger] = "you aren't supposed to be looking at this project."
      redirect_to user_projects_path(@user)
    end
  end

  def new
    if @user.groups.count == 0
      flash[:warning] = "sorry, seems like you don't belong to any groups yet, please contact your administrator or email tom@loopd.in"
      redirect_to user_projects_path(@user)
    else
      @project = Project.new(user: @user)
    end
  end

  def create
    project = Project.create(user_id: @user.id, title: params[:project][:title], description: params[:project][:description])
    if project.save!
      assign_group(project)
      assign_collaborators(project)
      add_version(project)
      notify_collaborators(project)
      flash[:notice] = "new project created"
      redirect_to user_projects_path(@user)
    else
      flash[:warning] = project.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def update
    @project = Project.find_by_slug(params[:id])
    if params[:approved]
      @project.approve!
    elsif params[:needs_work]
      @project.needs_work!
    elsif params[:add_user]
      user = User.find_by_username(params[:username])
      @project.collaborations.create(user_id: user.id)
      notify_collaborators(@project, user)
    elsif params[:remove_user]
      @project.collaborations.where(user_id: User.find_by_username(params[:username]).id).first.destroy
    end
    render :nothing => true
  end

  private

  def assign_collaborators(project)
    params[:collaboration][:user].split(', ').each do |c|
      Collaboration.create(project_id: project.id, user_id: User.find_by_username(c).id)
    end
  end

  def add_version(project)
    project.versions.create(title: params[:version][:title], description: params[:version][:description], file: params[:version][:file])
    project.save!
  end

  def assign_group(project)
    if @user.groups.count == 1
      project.group = @user.groups.first
    else
      project.group = Group.find params[:project][:group]
    end
    project.save!
  end

  def notify_collaborators(project, user = nil)
    users = if user.present?
      [user]
    else
      User.where(id: project.collaborations.map(&:user_id))
    end

    ProjectMailer.new_collaboration_notification(users, project).deliver if users.present?
  end

  def find_user
    @user = User.find_by_username(params[:user_id])
  end

  def user_permitted?
    current_user.belongs_to?(@project.group)
  end

  def version_params
    params[:version].permit(:title, :file, :description)
  end

end
