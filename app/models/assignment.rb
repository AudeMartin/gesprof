class Assignment < ApplicationRecord
  after_create :define_pending
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
  scope :daily_for, ->(school) { where(date: Date.today, school: school) }
  scope :daily_availables, -> { where(teacher_id: nil, date: Date.today) }
  scope :daily_availables_for, ->(school) { where(teacher_id: nil, date: Date.today, school: school) }
  scope :not_availables, -> { where.not(teacher_id: nil) }

  def self.ordered_by_priority
    (daily_availables.sort_by { |ass| ass.school.classes_number }).sort_by { |ass| (1.0/ass.school.ratio) }
  end

  def assign_one_teacher
    school_ref = School.near([self.school.latitude, self.school.longitude], 100, units: :km)
                       .where(area: self.school.area).where.not(teachers: nil)
                       .joins(:teachers).where(teachers: { id: Teacher.daily_availables }).first
    teach_of_day = []
    school_ref.teachers.each do |teacher|
      teach_of_day << teacher if teacher.daily_available?
    end
    self.teacher = teach_of_day.sample
    self.progress = 2
    self.send_token
    save
  end

  def self.assign_all
    while daily_availables.present? && first.school.area.teachers.daily_availables.present?
      to_assign = ordered_by_priority.first
      to_assign.assign_one_teacher
    end
  end

  def self.archive_old
    Assignment.where("date < ?", Date.today).each do |assignment|
      assignment.progress = 4
      assignment.save
    end
  end

  def self.validated(current_user)
    Assignment.includes(:school).where(
      date: Date.today,
      progress: "validated",
      school: current_user.area.schools
    )
  end

  def self.teachers_assigned(current_user)
    Assignment.includes(:school).where(
      school: current_user.area.schools,
      progress: 2,
      date: Date.today
    )
  end

  private

  def send_token
    if self.token.blank?
      self.token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def define_pending
    pending!
  end
end
