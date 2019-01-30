class Tank < ApplicationRecord
  belongs_to :user
  has_many :sensors
  has_many :readings
  has_many :devices

  def has_temp_sensor_configured?
    (self.temp_sensor_id.present?)
  end 
end
