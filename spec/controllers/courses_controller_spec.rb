require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET #index" do
    context "user is signed in" do
      it "renders the index template" do
        sign_in user

        get :index

        expect(response).to render_template(:index)
      end
    end

    context "user is not signed in" do
      it "does not render the index template" do
        get :index
        
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      sign_in user
      course = FactoryGirl.create(:course, user_id: user.id)

      get :show, id: course.id

      expect(response).to render_template(:show)
    end
  end

end
