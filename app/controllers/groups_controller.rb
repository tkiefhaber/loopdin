class GroupsController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_user_id(params[:id])
  end

end