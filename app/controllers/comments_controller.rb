class CommentsController < ApplicationController
  before_filter :find_user
  before_filter :find_project
  before_filter :find_version

  def new
    @comment = Comment.new(version: @version)
  end

  def create
    comment = Comment.new(create_params)
    comment.start_time = params[:comment][:start_time].to_i
    comment.user_id = current_user.id
    comment.version = @version
    if comment.save
      flash[:notice] = "new comment added"
      redirect_to user_project_path(@user, @project)
    else
      flash[:warning] = "something went wrong, try again"
      redirect_to :back
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

  def create_params
    params.permit(:user_id, :comment_id, :version_id, :id, :text, :start_time, :important, :addressed)
  end

  def comment_params
    params.permit(:user_id, :comment_id, :version_id, :project_id, :id, :text, :start_time, :important, :addressed)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_version
    @version = Version.find(params[:version_id])
  end
end
 
