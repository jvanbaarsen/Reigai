require 'securerandom'
class Application < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :logs

  validates :api_key, presence: true
  validates :name, presence: true

  after_initialize :create_api_key

  def create_log_from_api!(data)
    logs.create!(log_type: data[:type], message: data[:message])
  end

  private
  def create_api_key
    begin
      self.api_key = SecureRandom.uuid
    end while Application.exists?(api_key: self.api_key)
  end
end

