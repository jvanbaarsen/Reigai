require 'spec_helper'

describe Log do
  context "Relations" do
    it {should belong_to(:application)}
  end

  context 'Validations' do
    it {should validate_presence_of(:application)}
    it {should validate_presence_of(:log_type)}
    it {should validate_presence_of(:message)}
  end
end
