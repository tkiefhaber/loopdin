class ProjectsController < ApplicationController
  before_filter :find_user

  def index
    @projects = @user.all_projects
  end

  def show
    @project = Project.find_by_slug(params[:id])
  end

  def new
    @project = Project.new(user: @user)
  end

  def create
    project = Project.new(
      user_id: @user.id,
      title: params[:project][:title],
      description: params[:project][:description],
    )

    group = Group.find_by_slug(current_subdomain)
    project.group = group if group.present?

    if project.save
      assign_collaborators(project)
      notify_collaborators(project)
      flash[:notice] = "new project created"
      if group.present?
        redirect_to root_path(subdomain: group.slug)
      else
        redirect_to root_path
      end
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
      @proejct.needs_work!
    end
    render :nothing => true
  end

  private

  def assign_collaborators(project)
    params[:collaboration][:user].split(', ').each do |c|
      Collaboration.create(project_id: project.id, user_id: User.find_by_username(c).id)
    end
  end

  def notify_collaborators(project)
    ProjectMailer.new_collaboration_notification(User.where(id: project.collaborations.map(&:user_id)), project).deliver
  end

  def find_user
    @user = User.find_by_username(params[:user_id])
  end

end
