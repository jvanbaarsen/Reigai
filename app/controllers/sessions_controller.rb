class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      flash.now[:notice] = "Signed in"
    else
      flash.now[:error] = "Email or password was invalid"
    end
    render :new
  end

  def destroy
    logout
    redirect_to sign_in_path, notice: 'Succesfully logged out'
  end
end
