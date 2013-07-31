require 'json'
class LogsController < ApplicationController
  def create
    begin
      data = convert_hash_keys_to_symbols(JSON.parse(params[:data]))
      app = Application.find_by!(api_key: data[:api_key])
      if app.logs.build_from_api(data).save!
        render nothing: true, status: 200
      end
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: 401
    rescue TypeError, ActiveRecord::RecordInvalid
      render nothing: true, status: 400
    end
  end


  private
  def convert_hash_keys_to_symbols(hash)
    Hash[hash.map{ |k, v| [k.to_sym, v] }]
  end

  def render_400
    render nothing: true, status: 400
  end
end
