class AccountActivationsController < ApplicationController
  before_action :check_user, :edit

  def edit
    if !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t ".account_activated"
      redirect_to @user
    else
      flash[:danger] = t ".invalid_activation_link"
      redirect_to root_url
    end
  end

  private
  def check_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t ".user_not_found"
    redirect_to root_url
  end
end
