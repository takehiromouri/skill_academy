class CoursesController < ApplicationController
  before_action :authenticate_user!

  impressionist actions: [:show]

  def index  
    if params[:query].present?
      @courses = Course.search(params[:query]).records
    elsif params[:course]
      if params[:course][:sort_by_column].present?
        if params[:course][:sort_by_column] == "views"
          @courses = Course.all.sort_by(&:impressionist_count)
        else
          @courses = Course.order("#{params[:course][:sort_by_column]} #{params[:course][:sort_order]}")
        end
      elsif params[:course][:category].present?
        @courses = Course.where(category: params[:course][:category])
                         .order("average_rating DESC")
      end
    else  
      @courses = Course.order("average_rating DESC")
    end
  end

  def show
    @course = Course.includes(:ratings).find(params[:id])
    @instructor = @course.instructor
    @enrollment = current_user.enrollments.find_by(course_id: @course.id)
  end

end
