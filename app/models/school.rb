class School < ApplicationRecord
  belongs_to :area
  belongs_to :user
  has_many :teachers, dependent: :destroy
  has_many :assignments, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :classes_number, presence: true

  geocoded_by :address
  accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  def ratio
    Assignment.daily_availables_for(self).count.fdiv(classes_number)
  end
end
