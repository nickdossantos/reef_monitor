class Sensor < ApplicationRecord

  belongs_to :user
  belongs_to :tank
  has_many :readings, dependent: :destroy
end
