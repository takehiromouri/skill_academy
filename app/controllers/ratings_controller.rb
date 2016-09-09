class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_instructor, only: :create
  before_action :check_rating_owner, only: :destroy

  def create
    @rating = current_user.ratings.create(rating_params)
    # send email
  end

  def destroy
    @rating.destroy
    redirect_to course_path(@rating.course)
  end

  private

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
