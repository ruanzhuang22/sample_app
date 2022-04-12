class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: to_down_case(params[:session][:email])
    if user&.authenticate(params[:session][:password])
      if user.activated?
        accept_user user
      else
        warn_activation
      end
    else
      flash.now[:danger] = t ".invalid_user"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def to_down_case str
    str.downcase
  end

  def accept_user user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end

  def warn_activation
    flash[:warning] = t ".activation_warning"
    redirect_to root_url
  end
end
