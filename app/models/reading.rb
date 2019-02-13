class Reading < ApplicationRecord
  belongs_to :user
  belongs_to :tank
  belongs_to :sensor


  #==============================
  # Validations
  #==============================
  validates :date, presence: true
  validates :sensor_id, presence: true
  validates :user_id, presence: true
  
end
