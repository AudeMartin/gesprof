class School < ApplicationRecord
  belongs_to :area
  belongs_to :user
  has_many :teachers, dependent: :destroy
  has_many :assignments, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :classes_number, presence: true

  geocoded_by :address

  def ratio
    Assignment.daily_availables_for(self).count.fdiv(classes_number)
  end

  def absences
    Assignment.daily_availables_for(self).count
  end
end
