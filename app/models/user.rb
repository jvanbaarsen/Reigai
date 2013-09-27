class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :subscriptions
  has_many :applications, through: :subscriptions

  validates :email, presence: true, uniqueness:true, email_format: true
  validates :password, presence: true
end
