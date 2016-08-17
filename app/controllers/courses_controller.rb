class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @instructor = @course.user
    @enrollment = current_user.enrollments.find_by(course_id: @course.id)
  end

end
