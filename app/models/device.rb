class Device < ApplicationRecord
    include Friendlyable
    belongs_to :user
    belongs_to :tank
end
