class CoursesController < ApplicationController
  before_action :authenticate_user!

  impressionist actions: [:show]

  def index
    if params[:query].present?
      @courses = Course.search(params[:query]).records
    else  
      @courses = Course.all
    end
  end

  def show
    @course = Course.find(params[:id])
    @instructor = @course.user
    @enrollment = current_user.enrollments.find_by(course_id: @course.id)
  end

end
