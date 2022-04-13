class PasswordResetsController < ApplicationController
  before_action :load_user, except: :new
  before_action :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t ".email_sent_message"
    redirect_to root_url
  end

  def edit; end

  def update
    if @user.update(user_params)
      log_in @user
      flash[:success] = t ".reset_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".reset_fail"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    email = params.dig(:password_reset, :email) || params[:email]

    @user = User.find_by email: email.downcase
    return if @user

    flash.now[:danger] = t ".not_found"
    render :new, status: :unprocessable_entity
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    flash.now[:danger] = t ".not_found"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".password_expire"
    redirect_to new_password_reset_url
  end
end
