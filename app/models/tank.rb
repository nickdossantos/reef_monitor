class Tank < ApplicationRecord
  belongs_to :user
  has_many :sensors
  has_many :readings
end
