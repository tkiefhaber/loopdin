class GroupsController < ApplicationController
  before_filter :find_user

  def index
    if @user.username == 'rustychicken'
      @groups = Group.all
    else
      flash[:warning] = 'YOU SHALL NOT PASS'
      redirect_to user_projects_path(@user)
    end
  end

  def new
    if @user.username == 'rustychicken'
      @group = Group.new
    else
      flash[:warning] = 'YOU SHALL NOT PASS'
      redirect_to user_projects_path(@user)
    end
  end

  def create
    @group = Group.create(title: params[:group][:title])
    params[:user][:username].split(', ').each do |username|
      user = User.find_by_username(username)
      if user.present?
        @group.group_users.create(user: user)
      end
    end
    if @group.save
      flash[:success] = "Group and members added"
      redirect_to user_projects_path(current_user)
    else
      flash[:warning] = @group.errors.full_messages.to_sentence
      redirect_to user_projects_path(@user)
    end
  end

  def edit
    @group = Group.find_by_slug(params[:id])
    if @group.admin?(@user)
    else
      flash[:warning] = 'YOU SHALL NOT PASS'
      redirect_to user_projects_path(@user)
    end
  end

  def update
    @group = Group.find_by_slug(params[:id])
    user = User.find_by_username(params[:username])
    if params[:add_user].present?
      unless GroupUser.where(group_id: @group.id, user_id: user.id).present?
        GroupUser.create(group_id: @group.id, user_id: user.id)
      end
    end
    if params[:admin].present?
      @group.group_users.where(user_id: user.id).first.update_attributes(admin: params[:admin])
    end
    render :nothing => true
  end

  def destroy
    @group = Group.find_by_slug(params[:id])
    user = User.find_by_username(params[:username])
    @group.group_users.where(user_id: user.id).first.destroy
    render :nothing => true
  end

  private

  def find_user
    @user = User.find_by_username(current_user.username)
  end

end
