class Assignment < ApplicationRecord
  belongs_to :school
  belongs_to :teacher, optional: true

  # validates :date, presence: true
  # validates :progress, presence: true

  enum progress: {
    pending: 1,
    validated: 2,
    refused: 3,
    archived: 4
  }

  scope :daily, -> { where(date: Date.today) }
  scope :daily_availables, -> { where(teacher_id: nil, date: Date.today) }
  scope :daily_availables_for, ->(school) { where(teacher_id: nil, date: Date.today, school: school) }
  scope :not_availables, -> { where.not(teacher_id: nil) }

  def self.ordered_by_priority
    (daily_availables.sort_by { |ass| ass.school.classes_number }).sort_by { |ass| (1.0/ass.school.ratio) }
  end

  def self.assign_one_teacher
    to_assign = ordered_by_priority.first
    school_ref = School.near([to_assign.school.latitude, to_assign.school.longitude], 100, units: :km)
                       .where(area: to_assign.school.area).where.not(teachers: nil)
                       .joins(:teachers).where(teachers: { id: Teacher.daily_availables }).first
    to_assign.teacher = school_ref.teachers.sample
    to_assign.progress = 2
    to_assign.save
  end

  def self.assign_all
    assign_one_teacher while daily_availables.present? && first.school.area.teachers.daily_availables.present?
  end

  def self.archive_old
    Assignment.where("date < ?", Date.today).each do |assignment|
      assignment.progress = 4
    end
  end
end
