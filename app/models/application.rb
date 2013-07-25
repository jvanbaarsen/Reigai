class Application < ActiveRecord::Base
  belongs_to :user
  has_many :logs

  validates :user, presence: true
  validates :api_key, presence: true
end

