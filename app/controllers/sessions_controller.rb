class SessionsController < ApplicationController
  skip_before_action :logged_in?

  def new
  end

  def create
    p "inside"
    @temp = params[:session][:person]
    if @temp == 'subscriber'
      @member = Subscriber.find_by(email: params[:session][:email])
      session[:user_type] = 'subscriber'
    else
      @member = Author.find_by(email: params[:session][:email])
      session[:user_type] = 'author'
    end
    if @member && @member.authenticate(params[:session][:password])
      log_in @member
    else
      redirect_to @temp == 'subscriber' ? subscriber_login_path : author_login_path and return
    end
    p current_user
    redirect_to @temp == 'subscriber' ? subscriber_dashboard_path : author_dashboard_path and return
  end

  def destroy
    log_out
    redirect_to session[:user_type] == 'subscriber' ? subscriber_login_path : author_login_path
    session.delete(:user_type)
    return
  end
end
