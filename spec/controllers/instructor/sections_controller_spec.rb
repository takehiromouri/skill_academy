require 'rails_helper'

RSpec.describe Instructor::SectionsController, type: :controller do
  describe "GET #new" do
    context "user is instructor of course" do
      it "renders the new template" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)

        sign_in user
        get :new, course_id: course.id

        expect(response.status).to render_template :new
      end
    end

    context "user is not instructor of course" do
      it "redirects the user" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)

        sign_in user
        get :new, course_id: course.id

        expect(response.status).to redirect_to courses_path
      end
    end
  end

  describe "POST #create" do
    context "attributes are valid" do
      it "creates a new section" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)

        sign_in user

        expect {          
          post :create, course_id: course.id, section: { title: "Section Title" }
        }.to change(Section, :count).by(1)
      end
    end

    context "attributes are invalid" do
      it "doesn't create a new section" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)

        sign_in user

        expect {          
          post :create, course_id: course.id, section: { title: nil }
        }.to change(Section, :count).by(0)
      end
    end
  end
  
end
