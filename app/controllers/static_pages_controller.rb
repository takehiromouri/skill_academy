class StaticPagesController < ApplicationController
  def home
    return redirect_to courses_path if user_signed_in?

    @top_courses = Course.order("average_rating DESC").limit(5)
    
    render layout: 'layouts/landing_page'
  end
end
