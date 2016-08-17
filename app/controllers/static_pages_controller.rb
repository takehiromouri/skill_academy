class StaticPagesController < ApplicationController
  def home
    render layout: 'layouts/landing_page'
  end
end
