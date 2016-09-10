require 'rails_helper'

RSpec.describe Instructor::LessonsController, type: :controller do
  describe "GET #new" do
    context "user is instructor of course" do
      it "renders the new template" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)
        section = FactoryGirl.create(:section, course_id: course.id)

        sign_in user
        get :new, section_id: section.id

        expect(response.status).to render_template :new
      end
    end

    context "user is not instructor of course" do
      it "redirects the user" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)
        section = FactoryGirl.create(:section, course_id: course.id)

        sign_in user
        get :new, section_id: section.id

        expect(response.status).to redirect_to courses_path
      end
    end
  end

  describe "POST #create" do
    context "attributes are valid" do
      it "creates a new lesson" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)
        section = FactoryGirl.create(:section, course_id: course.id)

        sign_in user

        expect {          
          post :create, section_id: section.id, lesson: FactoryGirl.attributes_for(:lesson, section_id: section.id)
        }.to change(Lesson, :count).by(1)
      end
    end

    context "attributes are invalid" do
      it "doesn't create a new lesson" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)
        section = FactoryGirl.create(:section, course_id: course.id)

        sign_in user

        expect {          
          post :create, section_id: section.id, lesson: FactoryGirl.attributes_for(:lesson, title: nil, section_id: section.id)
        }.to change(Lesson, :count).by(0)
      end
    end
  end
end
