class School < ApplicationRecord
  belongs_to :area
  belongs_to :user
  has_many :teachers, dependent: :destroy
  has_many :assignments, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :classes_number, presence: true
end
