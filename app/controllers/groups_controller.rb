class GroupsController < ApplicationController
  before_filter :find_user

  def index
    if @user.id == 1
      @groups = Group.all
    else
      flash[:warning] = 'YOU SHALL NOT PASS'
      redirect_to :back
    end
  end

  def new
    @group = Group.new
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
      redirect_to :back
    end
  end

  def edit
    @group = Group.find_by_title(params[:id])
  end

  private

  def find_user
    @user = User.find_by_username(current_user.username)
  end

end
