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
  

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_api_configured?
    self.api_endpoint.present?
  end
end
