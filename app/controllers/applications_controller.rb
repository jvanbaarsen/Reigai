class ApplicationsController < ApplicationController
  def show

  end

  def new
    @application = current_user.applications.new
  end

  def create
    @application = current_user.applications.new(application_params)
    if @application.save
      flash[:success] = 'Your application has been created'
      redirect_to application_path(@application)
    else
      render :new
    end
  end

  private
  def application_params
    params.require(:application).permit([:name])
  end
end