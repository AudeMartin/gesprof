class School < ApplicationRecord
  belongs_to :area
  belongs_to :user
  belongs_to :user, through: :areas
  has_many :teachers
  has_many :assignments

  validates :name, presence: true
  validates :address, presence: true
  validates :classes_number, presence: true
end
