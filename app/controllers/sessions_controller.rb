class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      flash[:notice] = "Signed in"
    else
      flash[:alert] = "Email or password was invalid"
    end
    render :new
  end
end
