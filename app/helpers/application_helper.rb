module ApplicationHelper

  def to_percentage(school, type ='current')
    if type == 'init'
      (school.init_ratio * 100).round(2)
    else
      (school.ratio * 100).round(2)
    end
  end
end
