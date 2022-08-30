class Assignment < ApplicationRecord
  belongs_to :school
  belongs_to :teacher, optional: true

  validates :date, presence: true
  validates :progress, presence: true

  scope :daily, -> { where(date: Date.today) }
  scope :daily_availables, -> { where(teacher_id: nil, date: Date.today) }
  scope :not_availables, -> { where.not(teacher_id: nil) }

  def self.ordered_by_priority
    daily_availables.sort_by { |ass| [ass.school.ratio, (1.0 / ass.school.classes_number)] }
  end

  def self.assign_one_teacher
    to_assign = ordered_by_priority.first
    nearest_teacher = Teachers.where(school.address.near(to_assign.school.address)).first
    to_assign.teacher = nearest_teacher
    to_assign.save
  end

  def self.assign_all
    while (daily_availables.present?) && (Teachers.daily_availables.present?)
      assign_one_teacher
    end
  end
end
