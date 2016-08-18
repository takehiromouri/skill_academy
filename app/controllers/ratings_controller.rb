class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_instructor

  def create
    @rating = current_user.ratings.create(rating_params)
  end

  private

  def check_instructor
    @course = Course.find(params[:course_id])
    redirect_to course_path(@course) if @course.user == current_user
  end

  def rating_params
    params.require(:rating).permit(:stars, :comment).merge(course_id: params[:course_id])
  end
end
