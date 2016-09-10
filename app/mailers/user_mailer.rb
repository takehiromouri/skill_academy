class UserMailer < ApplicationMailer
  default from: "contact@skillacademy.com"

  def course_created(user, course)
    @user = user
    @course = course
    mail(to: @user.email, subject: "Congratulations! Your course #{@course.title} has been created!")
  end

  def enrolled(user, course)
    @user = user
    @course = course
    mail(to: @user.email, subject: "Congratulations! You have been enrolled to #{@course.title}!")
  end
end
