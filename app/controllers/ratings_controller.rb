class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_instructor, only: :create
  before_action :check_enrollment, only: :create
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
    current_rating.destroy
    flash[:success] = "Rating deleted!"
    redirect_to course_path(current_rating.course)
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def current_rating
    @current_rating ||= Rating.find(params[:id])
  end

  def check_enrollment
    return if current_user.enrolled_in?(current_course)
    flash[:alert] = "You can't rate a course that hasn't started yet!"
    redirect_to course_path(current_course)
  end

  def check_rating_owner
    return if current_rating.user == current_user
    flash[:alert] = "Unauthorized."
    redirect_to course_path(current_rating.course)
  end

  def check_instructor
    if current_course.instructor == current_user
      flash[:alert] = "You can't rate your own course!"
      redirect_to course_path(current_course) 
    end
  end

  def rating_params
    params.require(:rating).permit(:stars, :comment).merge(course_id: params[:course_id])
  end
end
