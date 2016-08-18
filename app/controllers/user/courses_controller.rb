class User::CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = current_user.enrolled_courses
  end
end
