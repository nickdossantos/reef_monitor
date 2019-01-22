class Tank < ApplicationRecord
  belongs_to :user
  has_many :sensors
  has_many :readings
  has_many :devices
end
