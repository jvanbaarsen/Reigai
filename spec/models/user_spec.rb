require 'spec_helper'

describe User do
  describe "Relations" do
    it {should have_many(:applications).through(:subscriptions)}
  end

  describe 'Validations' do
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

  describe "Fields" do
    it {should respond_to(:email)}
    it {should respond_to(:password)}
    it {should respond_to(:full_name)}
  end

  describe '#subscribe' do
    it "subscribed the user to a given application" do
      user = FactoryGirl.create(:user)
      application = FactoryGirl.create(:application)
      user.subscribe(application)
      expect(user.applications).to include(application)
    end
  end
end
