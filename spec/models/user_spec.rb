require 'spec_helper'

describe User do
  describe "Relations" do
    it {should have_many(:applications)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:email)}
  end
end
