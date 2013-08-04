FactoryGirl.define do
  salt = "asdasdasdasd1234adsasd"
  factory :user do
    email "info@example.com"
    password "secret"
    salt salt
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt)
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

