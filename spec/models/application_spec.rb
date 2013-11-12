require 'spec_helper'

describe Application do
  context "Relations" do
    it {should have_many(:users).through(:subscriptions)}
    it {should have_many(:logs)}
  end

  context 'Validations' do
    it {should validate_presence_of(:api_key)}
    it {should validate_presence_of(:name)}
  end

  context '#create_log_from_api!' do
    context 'when called with valid information' do
      it 'returns a new log object' do
        application = FactoryGirl.create(:application)
        log = application.create_log_from_api!({
          type: 'log',
          message: 'Awesome log'
        })
        expect(log).to be_a(Log)
      end
    end

    context 'when called with invalid information' do
      it 'raises an ActiveRecord::RecordInvalid error' do
        application = FactoryGirl.create(:application)
        expect {
          application.create_log_from_api!({})
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  it "creates its own api key when created" do
    application = Application.create
    expect(application.api_key).not_to eq(nil)
  end
end
