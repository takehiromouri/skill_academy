class LessonsController < ApplicationController
  before_action :check_user_enrollment

  def index    
    @sections = current_course.sections.includes(:lessons).order(:id)
    @course = current_course
  end
  
  def show     
    @lesson = current_lesson
  end

  private

  def check_user_enrollment
    return if current_course.instructor == current_user
    return if current_user.enrolled_in?(current_course)
    flash[:alert] = "You're not enrolled in this course!"
    redirect_to course_path(current_course)
  end

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
