class Area < ApplicationRecord
  belongs_to :user
  has_many :schools, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
