require 'spec_helper'
describe Api::V1::LogsController do
  context "#create" do
    it 'Renders status 200 when valid data is passed into it' do
      @controller.stub(:app).and_return Application.new
      Application.any_instance.stub(:create_log_from_api!)
      post :create, data: {}
      expect(response.status).to eq(200)
    end

    it 'Stores the log message for later retrieval' do
      application = FactoryGirl.create(:application)
      post :create, data: {
        type: 'log',
        message: 'Test message',
        api_key: application.api_key
      }
      expect(Log.last.message).to eq('Test message')
    end

    it 'Renders status 400 when invalid data was passed into it' do
      @controller.stub(:app).and_return Application.new
      Application.any_instance.stub(:create_log_from_api!).and_raise(ActiveRecord::RecordInvalid.new(Log.new))
      post :create, data: {}
      expect(response.status).to eq(400)
    end

    it 'Renders status 401 when an invalid API key was passed into it' do
      @controller.stub(:app).and_raise ActiveRecord::RecordNotFound
      post :create, data: {api_key: 'super invalid'}
      expect(response.status).to eq(401)
    end
  end
end

