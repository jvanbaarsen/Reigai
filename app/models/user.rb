class User < ActiveRecord::Base
  has_many :applications

  validates :email, presence: true
end
