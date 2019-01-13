class Device < ApplicationRecord
    belongs_to :user
    belongs_to :tank
end
