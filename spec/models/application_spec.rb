require 'spec_helper'

describe Application do
  describe "Relations" do
    it {should have_many(:users).through(:subscriptions)}
    it {should have_many(:logs)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:api_key)}
    it {should validate_presence_of(:name)}
  end

  describe 'Association extensions' do
    describe '.logs.build_from_api' do
      it 'responds to build_from_api' do
        expect(subject.logs).to respond_to(:build_from_api)
      end

      it 'retuns a log object' do
        expect(log).to be_a(Log)
      end

      it 'returns a valid log object' do
        expect(log).to be_valid
      end

      def log
        @log ||= FactoryGirl.create(:application).logs.build_from_api({type: 'log', message: 'Awesome log'})
      end
    end
  end

  it "creates its own api key when created" do
    application = Application.create
    expect(application.api_key).not_to eq(nil)
  end
end
