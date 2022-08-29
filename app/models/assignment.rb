class Assignment < ApplicationRecord
  belongs_to :school
  belongs_to :teacher, optional: true

  validates :date, presence: true
  validates :progress, presence: true
end
