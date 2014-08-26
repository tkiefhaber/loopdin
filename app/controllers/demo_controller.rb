class DemoController < ApplicationController
  respond_to :json, :html
  def show
    @user = User.find_by_username(params[:id])
    works = @user.projects.approved
    @timeline = Timeline.new(@user, works).format
    respond_with(@timeline)
  end
end
