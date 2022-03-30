class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
    return if @user

    flash[:danger] = t ".user_not_found"
    redirect_to help_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "success"
      redirect_to @user
    else
      flash.now[:danger] = t "fail_to_create"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
