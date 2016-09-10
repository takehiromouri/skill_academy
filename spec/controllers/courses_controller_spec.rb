require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe "GET #index" do
    context "user is signed in" do
      it "renders the index template" do
        user = FactoryGirl.create(:user)

        sign_in user
        get :index

        expect(response).to render_template(:index)
      end
    end

    context "user is not signed in" do
      it "does not render the index template" do
        user = FactoryGirl.create(:user)

        get :index
        
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      user = FactoryGirl.create(:user)
      course = FactoryGirl.create(:course, user_id: user.id)

      sign_in user
      get :show, id: course.id

      expect(response).to render_template(:show)
    end
  end

end
