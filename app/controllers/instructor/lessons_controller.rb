class Instructor::LessonsController < ApplicationController
  before_action :authenticate_instructor

  def new
    @lesson = Lesson.new
    @section = current_section
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    if @lesson.valid?
      flash[:success] = "New lesson created!"
      redirect_to instructor_course_path(current_section.course)
    else
      flash[:alert] = "Oops! There was an error!"
      render :new
    end
  end

  private

  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content, :row_order).merge(section_id: params[:section_id])
  end

  def authenticate_instructor
    @course = current_section.course

    return if @course.instructor == current_user
    flash[:alert] = "Unauthorized!"
    redirect_to courses_path
  end
end
