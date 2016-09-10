require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  describe "GET #index" do
    context "user is enrolled" do
      it "renders the index template" do
        @user = FactoryGirl.create(:user)
        build_course_by(@user.id + 1)
        enrollment = FactoryGirl.create(:enrollment, course_id: @course.id, user_id: @user.id)

        sign_in @user
        get :index, course_id: @course.id

        expect(response.status).to render_template :index
      end
    end

    context "user is not enrolled" do
      it "redirects the user" do
        @user = FactoryGirl.create(:user)
        build_course_by(@user.id + 1)

        sign_in @user
        get :index, course_id: @course.id

        expect(response.status).to redirect_to course_path(@course)
      end
    end
  end


  describe "GET #show" do
    context "user is enrolled" do
      it "renders the show template" do
        @user = FactoryGirl.create(:user)
        build_course_by(@user.id + 1)
        enrollment = FactoryGirl.create(:enrollment, course_id: @course.id, user_id: @user.id)

        sign_in	@user
        get :show, course_id: @course.id, id: @lesson.id

        expect(response.status).to render_template :show
      end
    end

    context "user is not enrolled" do
      it "redirects the user" do
        @user = FactoryGirl.create(:user)
        build_course_by(@user.id + 1)      

        sign_in	@user
        get :show, course_id: @course.id, id: @lesson.id

        expect(response.status).to redirect_to course_path(@course)
      end
    end

    context "user is instructor" do
      it "renders the show template" do
        @user = FactoryGirl.create(:user)
        build_course_by(@user.id)

        sign_in	@user
        get :show, course_id: @course.id, id: @lesson.id

        expect(response.status).to render_template :show
      end
    end

  end

  def build_course_by(user_id)    
    @course = FactoryGirl.create(:course, user_id: user_id)
    @section = FactoryGirl.create(:section, course_id: @course.id)
    @lesson = FactoryGirl.create(:lesson, section_id: @section.id) 
  end
end
