class FollowersController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:id]
    @title = t ".followers_title"
    @pagy, @users = pagy @user.followers
    render :show_follow
  end
end
