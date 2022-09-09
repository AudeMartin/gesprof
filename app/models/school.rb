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

  def init_ratio
    Assignment.daily_for(self).count.fdiv(classes_number)
  end

  def absences
    Assignment.daily_for(self).count
  end

  def assigns_pending
    assignments.where(
      date: Date.today, progress: "pending"
    )
  end

  def today_assigns
    assignments.where(
      date: Date.today
    )
  end

  def rank(ratio)
    to_round_ratio = ratio * 100
    if to_round_ratio <= 10
      "low"
    elsif to_round_ratio > 10 && to_round_ratio <= 20
      "medium"
    else
      "high"
    end
  end
end
