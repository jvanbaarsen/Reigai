class Application < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :logs do
    def build_from_api(data)
      proxy_association.owner.logs.new(
        log_type: data[:type],
        message: data[:message]
      )
    end
  end

  validates :api_key, presence: true
end

