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

  def redirect_to_last_or_url(url)
    if(session[:last_request])
      local_last_request = session[:last_request].dup.symbolize_keys
      session[:last_request] = nil

      redirect_to local_last_request[:url], local_last_request[:params]
    else
      redirect_to url
    end
  end
end
