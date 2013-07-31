require 'spec_helper'
require 'json'

feature 'api' do
  scenario 'Sending a valid log message' do
    page.driver.post '/api/v1/notify.json', data: valid_log_message(app.api_key, 'This is awesome')
    expect(page.status_code).to eq(200)
    expect(Log.last.message).to eq('This is awesome')
  end

  scenario 'Sending a invalid log message' do
    page.driver.post '/api/v1/notify.json', data: invalid_log_message(app.api_key)
    expect(page.status_code).to eq(400)
  end

  scenario 'Sending a empty post to notify end-point' do
    page.driver.post '/api/v1/notify.json'
    expect(page.status_code).to eq(400)
  end

  scenario 'Sending a unknown api key with the notify end-point' do
    page.driver.post '/api/v1/notify.json', data: valid_log_message('invalid-key', 'This is awesome')
    expect(page.status_code).to eq(401)
  end

  def valid_log_message(api_key, message)
    log_data = {
      type: 'log',
      message: message,
      api_key: api_key
    }.to_json
  end

  def invalid_log_message(api_key)
    log_data = {
      type: 'log',
      api_key: api_key
    }.to_json
  end

  def app
    @app ||= FactoryGirl.create(:application)
  end
end
