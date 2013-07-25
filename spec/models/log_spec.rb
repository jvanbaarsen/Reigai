require 'spec_helper'

describe Log do
  describe "Relations" do
    it {should belong_to(:application)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:application)}
  end
end
