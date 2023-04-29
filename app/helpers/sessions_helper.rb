module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_type] == 'subscriber'
      @current_user ||= Subscriber.find_by(id: session[:user_id])
    else
      @current_user ||= Author.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    if current_user.nil?
      redirect_to subscriber_login_path and return
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end
end
