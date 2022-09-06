class Teacher < ApplicationRecord
  belongs_to :school
  has_many :assignments

  validates :name, presence: true
  validates :email, presence: true

  def self.daily_availables
    assigned_ids = Assignment.daily.not_availables.map(&:teacher_id)
    where.not(id: assigned_ids)
  end

  def input_format
    content_tag(:i, class: 'fa-solid fa-check')
  end
end
