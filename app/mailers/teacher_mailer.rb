class TeacherMailer < ApplicationMailer
  default from: 'noreply@gesprof.space'

  def teacher_email
    @teacher = params[:teacher]
    mail(to: @teacher.email, subject: 'Votre affectation du jour')
  end
end
