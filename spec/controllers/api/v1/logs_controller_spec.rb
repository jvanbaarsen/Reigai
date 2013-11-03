require 'json'
describe Api::V1::LogsController do
  context "#create" do
    it 'Renders status 200 when valid data is passed into it' do
      post :create, data: log_data.to_json
      expect(response.status).to eq(200)
    end

    it 'Stores the log message for later retrieval' do
      post :create, data: log_data.to_json
      expect(Log.last.message).to eq('Test message')
    end

    it 'Renders status 400 when invalid data was passed into it' do
      post :create
      expect(response.status).to eq(400)
    end

    it 'Renders status 401 when an invalid API key was passed into it' do
      log = log_data
      log[:api_key] = 'Invalid_key'
      post :create, data: log.to_json
      expect(response.status).to eq(401)
    end
  end
end

def log_data
  @log_data ||= {
    type: 'log',
    message: 'Test message',
    api_key: application.api_key
  }
end

def application
  @application ||= FactoryGirl.create(:application)
end
