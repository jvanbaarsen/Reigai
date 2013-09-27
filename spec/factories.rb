FactoryGirl.define do

  factory :user do
    full_name "John Doe"
    email "info@example.com"
    password 'secret'
    password_confirmation 'secret'
    salt "asdasdasdasd1234adsasd"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdasdasd1234adsasd")
  end

  factory :log do
    application
    log_type "log"
    message "Awesome log"
  end

  factory :subscription do
    application
    user
  end

  factory :application do
  end
end

