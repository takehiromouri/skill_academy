class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_instructor, only: [:show, :edit, :update]

  def index
    @courses = current_user.courses.all
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.includes(:sections, :lessons).find(params[:id])
    @instructor = @course.instructor
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      UserMailer.course_created(current_user, @course).deliver
      flash[:success] = "Congratulations! Your course has been created!"
      redirect_to course_path(@course) 
    else
      flash[:danger] = "Sorry, it looks like there was an error."
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      flash[:success] = "Course updated!"
      redirect_to course_path(@course)
    else
      flash[:danger] = "Woops, looks like there was an error."
      render :edit
    end
  end

  private

  def check_instructor
    @course = Course.find(params[:id])
    return if @course.instructor == current_user
    flash[:alert] = "Too bad, you're unauthorized!"
    redirect_to courses_path
  end

  def course_params
    params.require(:course).permit(:title, :description, :price, :start_time, :end_time, 
                                    :category, :user_id, :target, :location, :address, :photo)
  end
end
