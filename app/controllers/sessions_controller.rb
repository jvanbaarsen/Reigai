class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      flash.now[:notice] = "Signed in"
      redirect_to root_path
    else
      flash.now[:error] = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'Succesfully logged out'
  end
end
