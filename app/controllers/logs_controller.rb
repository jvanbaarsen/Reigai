class LogsController < ApplicationController
  def create
    render nothing: true, status: 200
  end
end
