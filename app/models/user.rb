class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :area, dependent: :destroy
  has_one :school, dependent: :destroy
  has_many :schools, through: :areas

  validates :role, presence: true

  enum role: {
    gestionnaire: 1,
    directeur: 2,
    teacher: 3
  }
end
