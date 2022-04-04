class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to login_url
    else
      flash.now[:danger] = t ".invalid_user"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
