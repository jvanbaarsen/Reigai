require 'spec_helper'

describe Subscription do
  describe "Relations" do
    it {should belong_to(:user)}
    it {should belong_to(:application)}
  end
end