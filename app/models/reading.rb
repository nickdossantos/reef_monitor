class Reading < ApplicationRecord

  belongs_to :user
  belongs_to :tank
  belongs_to :sensor, dependent: :destroy
end
