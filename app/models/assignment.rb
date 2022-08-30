class Assignment < ApplicationRecord
  belongs_to :school
  belongs_to :teacher, optional: true

  validates :date, presence: true
  validates :progress, presence: true

  enum progress: {
    pending: 1,
    validated: 2,
    refused: 3,
    archived: 4
  }
end
