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
end
