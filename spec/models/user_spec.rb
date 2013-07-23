require 'spec_helper'

describe User do
  describe "attributes" do
    describe "#email" do
      it "validates the existence of the email field" do
        user = User.new
        expect(user).to have(1).error_on(:email)
      end
      it "has the value of 'info@example.com'" do
        user = User.new(:email => 'info@example.com')
        expect(user.email).to eq('info@example.com')
      end
    end
  end
end
