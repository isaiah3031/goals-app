class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :ensure_login, :belongs_to_user

  def login(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_login
    logged_in? ? (true) : (redirect_to :new_session)
  end

  def belongs_to_user(goal)
    current_user.id == goal.author_id
  end

  def user_has_access(goal)
    return current_user.id == goal.author_id if goal.private?
    true
  end
end
