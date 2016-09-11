class CoursesController < ApplicationController  

  before_action :authenticate_user!

  impressionist actions: [:show]

  def index  
    @courses = Course.order("average_rating DESC")
    @courses = Course.search(params[:query]).records if params[:query].present?    
    

    if params[:course]
      @courses = Course.filter(params[:course][:category]) if params[:course][:category]    
      @courses = Course.sort_by_attribute(params[:course][:sort_by_column]) if params[:course][:sort_by_column]
      @sort_by_column = params[:course][:sort_by_column] ? params[:course][:sort_by_column] : nil
      @category = params[:course][:category] ? params[:course][:category] : nil
    end
  end

  def show
    @course = current_course
    @instructor = @course.instructor
    @enrollment = current_user.enrollments.find_by(course_id: @course.id)
  end

  private

  def current_course
    @current_course ||= Course.includes(:ratings).find(params[:id])
  end

end
