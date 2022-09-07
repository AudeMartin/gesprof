class Teacher < ApplicationRecord
  belongs_to :school
  has_many :assignments

  validates :name, presence: true
  validates :email, presence: true

  def self.daily_availables
    assigned_ids = Assignment.daily.not_availables.map(&:teacher_id)
    where.not(id: assigned_ids)
  end

  def daily_available?
    Teacher.daily_availables.includes?(self)
  end
end
