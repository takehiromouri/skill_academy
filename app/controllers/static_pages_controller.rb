class StaticPagesController < ApplicationController
  def home
    return redirect_to courses_path if user_signed_in?
    render layout: 'layouts/landing_page'
  end
end
