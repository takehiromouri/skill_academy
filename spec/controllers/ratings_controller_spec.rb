require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
  end

  describe "POST #create" do
    context "user is not the course instructor" do
      it "creates a new rating" do
        course = FactoryGirl.create(:course, user_id: user.id + 1)        

        expect {
          post :create, course_id: course.id, rating: FactoryGirl.attributes_for(:rating), format: :js
        }.to change(Rating, :count).by(1)
      end
    end

    context "user is the course instructor" do
      it "should not create a new rating" do
        course = FactoryGirl.create(:course, user_id: user.id)

        expect {
          post :create, course_id: course.id, rating: FactoryGirl.attributes_for(:rating), format: :js
        }.to change(Rating, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    context "user created the rating" do

    end

    context "user did not create the rating" do
      
    end
  end

end
