class UsersController < ApplicationController
protect_from_forgery with: :exception

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to goals_url
    else
      flash.now[:errors] = 'invalid username or password'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
