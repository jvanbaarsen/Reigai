class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :determine_layout
  before_filter :require_login

  def applications
    @applications ||= current_user.applications
  end
  helper_method :applications

  private
  def determine_layout
    return 'login' unless current_user
    return 'application'
  end

  def not_authenticated
    flash[:alert] = "First login to access this page" unless request.fullpath == root_path
    redirect_to login_url
  end
end
