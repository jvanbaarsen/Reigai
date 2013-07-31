# Read about factories at https://github.com/thoughtbot/factory_girl
#
# The data model:
# t.integer  "user_id"
# t.string   "api_key"
# t.datetime "created_at"
# t.datetime "updated_at"

FactoryGirl.define do
  factory :application do
    user
    api_key "1234abcd"
  end
end
