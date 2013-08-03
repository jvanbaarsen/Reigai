FactoryGirl.define do
  factory :user do
    email "info@example.com"
  end

  factory :log do
    application
    log_type "log"
    message "Awesome log"
  end

  factory :application do
    user
    api_key "1234abcd"
  end
end

