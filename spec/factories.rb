FactoryGirl.define do

  factory :user do
    email "info@example.com"
    password 'secret'
    salt "asdasdasdasd1234adsasd"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdasdasd1234adsasd")
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

