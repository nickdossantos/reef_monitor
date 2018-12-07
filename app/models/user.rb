class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tanks, dependent: :destroy
  has_many :sensors, dependent: :destroy
  has_many :readings, dependent: :destroy

end
