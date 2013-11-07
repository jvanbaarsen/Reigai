require 'spec_helper'

describe Subscription do
  context "Relations" do
    it {should belong_to(:user)}
    it {should belong_to(:application)}
  end
end
