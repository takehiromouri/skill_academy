class Instructor::SectionsController < ApplicationController
  before_action :authenticate_instructor

  def new
    @section = Section.new
    @course = current_course
  end

  def create
    @section = current_course.sections.create(section_params)
    if @section.valid?  
      flash[:success] = "A new section has been added!"
      redirect_to instructor_course_path(current_course)
    else
      flash[:alert] = "Oops! There was an error!"
      render :new      
    end
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def section_params
    params.require(:section).permit(:title).merge(course_id: params[:course_id])
  end

  def authenticate_instructor
    @course = Course.find(params[:course_id])

    return if @course.instructor == current_user
    flash[:alert] = "Unauthorized!"
    redirect_to courses_path
  end
end
