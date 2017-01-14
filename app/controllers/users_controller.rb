class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless @user.save
      flash[:error] = "Could not create a user"
      redirect_to new_user_path and return
    end

    session[:user_id] = @user.id

    redirect_to_last_or_url(root_path)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
