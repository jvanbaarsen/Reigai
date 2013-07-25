require 'spec_helper'
require 'json'

feature 'api' do
  scenario 'Sending a valid log message' do
    page.driver.post '/api/v1/notify.json', data: raw_log_message
    expect(page.status_code).to eq(200)
  end

  def raw_log_message
    log_data = {
      type: 'log',
      payload: 'This is an awesome log message'
    }.to_json
  end
end
