class SessionController < ApplicationController
  def new
    render :new
  end

  # something wrong with find by credentials
  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      login(user)
      redirect_to :new_user
    else
      flash.now[:errors] = "Invalid credentials"
      render :new
    end
  end
  
  def destroy
    current_user.reset_session_token
    redirect_to :new_session
  end
end
