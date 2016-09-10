class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_instructor

  def create
    @enrollment = current_user.enrollments.create(course_id: params[:course_id])

    if @enrollment.valid?
      UserMailer.enrolled(current_user, @enrollment.course).deliver
      flash[:success] = "Congratulations! You're enrolled for this course!"
    else
      flash[:danger] = "Woops! Looks like there was an error. Please try again."
    end

    redirect_to course_path(@enrollment.course_id)
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.user == current_user
      @enrollment.destroy
      # send email
      flash[:success] = "You have been unenrolled from this course!"      
    else
      flash[:danger] = "Woops! You're unauthorized to do that!"      
    end
    redirect_to course_path(params[:course_id])
  end

  private

  def check_instructor
    return unless Course.find(params[:course_id]).instructor == current_user
    flash[:danger] = "Woops! You can't sign up for your own courses!"
    redirect_to course_path(params[:course_id])
  end

  def enrollment_params
    params.permit(:course_id)
  end
end
