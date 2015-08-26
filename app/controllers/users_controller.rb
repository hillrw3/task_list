class UsersController < ApplicationController
  attr_accessor :user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if user.save
      sign_in user
      redirect_to root_path
    else
      render new_user_path
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end