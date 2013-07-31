# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    application
    log_type "log"
    message "Awesome log"
  end
end
