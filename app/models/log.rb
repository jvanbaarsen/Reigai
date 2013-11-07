class Log < ActiveRecord::Base
  belongs_to :application

  validates :application, presence: true
  validates :log_type, presence: true
  validates :message, presence: true
end
