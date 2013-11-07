class ApplicationsController < ApplicationController
  def show
    @application = current_user.get_application(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      current_user.subscribe(@application)
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
