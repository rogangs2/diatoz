class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include SessionsHelper

  before_action :logged_in?
end
