class UsersController < ApplicationController
  def new
    redirect_to home_path if current_user
    @user = User.new
  end
  
  def create
    @user = User.new(permitted_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end
  
  private
  
  def permitted_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end