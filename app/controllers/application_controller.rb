class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :determine_layout

  def determine_layout
    return 'login' unless current_user
    return 'application'
  end

end
