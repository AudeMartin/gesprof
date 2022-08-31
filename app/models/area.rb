class Area < ApplicationRecord
  belongs_to :user
  has_many :schools, dependent: :destroy
  has_many :teachers, through: :schools

  validates :name, presence: true, uniqueness: true
end
