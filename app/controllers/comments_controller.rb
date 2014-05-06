class CommentsController < ApplicationController
  before_filter :find_user
  before_filter :find_project
  before_filter :find_version

  def new
    @comment = Comment.new(version: @version)
  end

  def create
    comment = Comment.new(comment_params)
    comment.start_time = params[:comment][:start_time].to_i
    comment.version = @version
    if comment.save
      flash[:notice] = "new comment added"
      redirect_to user_project_path(@user, @project)
    else
      flash[:warning] = "something went wrong, try again"
      redirect_to :back
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:text, :start_time)
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
 
