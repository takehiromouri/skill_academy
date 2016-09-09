require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  describe "POST #create" do
    context "user is not the course instructor" do
      it "creates a new rating" do
        user = FactoryGirl.create(:user)        
        course = FactoryGirl.create(:course, user_id: user.id + 1)        

        sign_in user

        expect {
          post :create, course_id: course.id, rating: FactoryGirl.attributes_for(:rating), format: :js
        }.to change(Rating, :count).by(1)
      end
    end

    context "user is the course instructor" do
      it "should not create a new rating" do
        user = FactoryGirl.create(:user)        
        course = FactoryGirl.create(:course, user_id: user.id)

        sign_in user

        expect {
          post :create, course_id: course.id, rating: FactoryGirl.attributes_for(:rating), format: :js
        }.to change(Rating, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    context "user created the rating" do
      it "deletes the rating" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)
        rating = FactoryGirl.create(:rating, user_id: user.id, course_id: course.id)

        sign_in user

        expect{
          delete :destroy, id: rating.id
        }.to change(Rating, :count).by(-1)
        expect(response.status).to redirect_to course_path(course)
      end
    end

    context "user did not create the rating" do
      it "doesn't delete the rating" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)
        rating = FactoryGirl.create(:rating, user_id: user.id + 1, course_id: course.id)

        sign_in user

        expect{
          delete :destroy, id: rating.id
        }.to change(Rating, :count).by(0)
        expect(response.status).to redirect_to course_path(course)
      end
    end
  end

end
