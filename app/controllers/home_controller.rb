class HomeController < ApplicationController
  def index
    @users = User.all
    @user = User.last
  end
end
