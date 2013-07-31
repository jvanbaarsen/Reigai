require 'spec_helper'

describe Application do
  describe "Relations" do
    it {should belong_to(:user)}
    it {should have_many(:logs)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:user)}
    it {should validate_presence_of(:api_key)}
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
end
