class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :applications

  validates :email, presence: true, uniqueness:true, email_format: true
  validates :password, presence: true
end
