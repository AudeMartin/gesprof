module ApplicationHelper

  def to_percentage(school, type ='current')
    if type == 'init'
      (school.init_ratio * 100).round
    else
      (school.ratio * 100).round
    end
  end
end
