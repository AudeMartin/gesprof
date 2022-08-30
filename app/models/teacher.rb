class Teacher < ApplicationRecord
  belongs_to :school
  has_many :assignments

  validates :name, presence: true
  validates :email, presence: true
end
