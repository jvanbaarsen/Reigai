require 'spec_helper'

describe User do
  context "Relations" do
    it {should have_many(:applications).through(:subscriptions)}
  end

  context 'Validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:full_name)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_confirmation_of(:password)}

    it "accepts a valid email address" do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end

    it "refuses an invalid email address" do
      user = FactoryGirl.build(:user, email: 'invalid@mail')
      expect(user).not_to be_valid
    end
  end

  context "Fields" do
    it {should respond_to(:email)}
    it {should respond_to(:password)}
    it {should respond_to(:full_name)}
  end

  context '#subscribe' do
    it "subscribed the user to a given application" do
      user = FactoryGirl.build(:user)
      application = FactoryGirl.build(:application)
      user.subscribe(application)
      expect(user.applications).to include(application)
    end
  end

  context '#get_application' do
    let(:user) {FactoryGirl.create(:user)}
    let(:application) {FactoryGirl.create(:application)}

    it 'Finds the application for the user' do
      user.subscribe(application)
      expect(user.get_application(application.id)).to eq(application)
    end

    it 'Throws an exception when the application was not found' do
      unknown_application_id = 10
      expect{user.get_application(unknown_application_id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
