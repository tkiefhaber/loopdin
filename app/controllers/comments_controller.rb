class CommentsController < ApplicationController
  before_filter :find_user
  before_filter :find_project
  before_filter :find_version
  before_filter :ensure_user_can_update, only: [:update]

  def new
    @comment = Comment.new(version: @version)
  end

  def create
    if !@project.collaborations.map(&:user_id).include?(current_user.id)
      flash[:error] = 'you are not authorized to comment on this project'
      redirect_to user_project_path(@project.user, @project)
    else
      comment = Comment.new
      comment.start_time = params[:comment][:start_time].to_i
      comment.text = params[:comment][:text]
      comment.user_id = current_user.id
      comment.version = @version
      if comment.save
        flash[:notice] = "new comment added"
        redirect_to user_project_path(@project.user, @project)
      else
        flash[:warning] = "something went wrong, try again"
        redirect_to :back
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if params[:important].present?
      hash = {important: params[:important]}
    elsif params[:addressed].present?
      hash = {addressed: params[:addressed]}
    else
      hash = {}
    end
    @comment.update_attributes(hash)
    render :nothing => true
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.permit(:user_id, :comment_id, :version_id, :project_id, :id, :text, :start_time, :important, :addressed)
  end

  def find_user
    @user = User.find_by_slug(params[:user_id])
  end

  def find_project
    @project = Project.find_by_slug(params[:project_id])
  end

  def find_version
    @version = Version.find(params[:version_id])
  end

  def ensure_user_can_update
    @project.user.id == current_user.id
  end
end
 
