class User < ApplicationRecord
  include Friendlyable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tanks, dependent: :destroy
  has_many :sensors, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :devices, dependent: :destroy

  enum sms_notification_frequency: {
    sms_never: 0,
    sms_daily: 1  
  }

  enum email_notification_frequency: {
    email_never: 0,
    email_daily: 1  
  }

  mount_uploader :picture, PictureUploader
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def has_api_configured?
    self.api_endpoint.present?
  end
end
