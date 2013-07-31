class Application < ActiveRecord::Base
  belongs_to :user
  has_many :logs do
    def build_from_api(data)
      proxy_association.owner.logs.new(
        log_type: data[:type],
        message: data[:message]
      )
    end
  end

  validates :user, presence: true
  validates :api_key, presence: true
end

