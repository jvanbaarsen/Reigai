class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :subscriptions
  has_many :applications, through: :subscriptions

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness:true, email_format: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  def subscribe(application)
    self.applications << application
  end

  def get_application(application_id)
    applications.find(application_id)
  end
end
