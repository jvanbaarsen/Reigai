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
        application = Application.new
        application.logs.stub(:create!).and_return Log.new
        log = application.create_log_from_api!({})
        expect(log).to be_a(Log)
      end
    end

    context 'when called with invalid information' do
      it 'raises an ActiveRecord::RecordInvalid error' do
        application = Application.new
        application.logs.stub(:create!).and_raise ActiveRecord::RecordInvalid.new(Log.new)
        expect {
          application.create_log_from_api!({})
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  it "creates its own api key when created" do
    application = Application.new
    expect(application.api_key).not_to eq(nil)
  end
end
