class FollowingController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:id]
    @title = t ".following_title"
    @pagy, @users = pagy @user.following
    render :show_follow
  end
end
