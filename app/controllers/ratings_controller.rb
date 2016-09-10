class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_instructor, only: :create
  before_action :check_course_start_time, only: :create
  before_action :check_rating_owner, only: :destroy

  def create
    @rating = current_user.ratings.new(rating_params)

    if @rating.save
      flash[:success] = "Rating added!"
    else
      flash[:alert] = "Oops! There was an error. Please try again."
    end

    redirect_to course_path(params[:course_id])    
  end

  def destroy
    @rating.destroy
    flash[:success] = "Rating deleted!"
    redirect_to course_path(@rating.course)
  end

  private

  def check_course_start_time
    return if @course.start_time < DateTime.now
    flash[:alert] = "You can't rate a course that hasn't started yet!"
  end

  def check_rating_owner
    @rating = Rating.find(params[:id])
    return if @rating.user == current_user
    flash[:alert] = "Unauthorized."
    redirect_to course_path(@rating.course)
  end

  def check_instructor
    @course = Course.find(params[:course_id])
    if @course.instructor == current_user
      flash[:alert] = "You can't rate your own course!"
      redirect_to course_path(@course) 
    end
  end

  def rating_params
    params.require(:rating).permit(:stars, :comment).merge(course_id: params[:course_id])
  end
end
