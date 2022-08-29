class Area < ApplicationRecord
  belongs_to :user
  has_many :schools

  validates :name, presence: true
end
