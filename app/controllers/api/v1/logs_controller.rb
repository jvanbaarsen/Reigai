require 'json'
class Api::V1::LogsController < ApplicationController
  skip_before_filter :require_login, only: [:create]
  def create
    begin
      app = Application.find_by!(api_key: data[:api_key])
      app.create_log_from_api!(data)
      render nothing: true, status: 200
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: 401
    rescue TypeError, ActiveRecord::RecordInvalid
      render nothing: true, status: 400
    end
  end

  private
  def data
    @data ||= params[:data] || {api_key: 'invalid'}
  end
end
