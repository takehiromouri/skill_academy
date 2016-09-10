require 'rails_helper'

RSpec.describe Instructor::CoursesController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      user = FactoryGirl.create(:user)

      sign_in user
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    context "user is instructor" do
      it "displays the show template" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id)

        sign_in user
        get :show, id: course.id

        expect(response.status).to render_template :show
      end
    end 

    context "user is not instructor" do
      it "redirects user to root_path" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)

        sign_in user
        get :show, id: course.id

        expect(response.status).to redirect_to courses_path
      end
    end
  end

  describe "GET #new" do
    context "user is signed in" do
      it "renders the new template" do
        user = FactoryGirl.create(:user)

        sign_in user
        get :new

        expect(response).to render_template(:new)
      end
    end

    context "user is not signed in" do
      it "redirects the user" do
        user = FactoryGirl.create(:user)

        get :new

        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST #create" do
    context "attributes are valid" do
      it "creates a new course" do
        user = FactoryGirl.create(:user)

        sign_in user

        expect {
          post :create, course: FactoryGirl.attributes_for(:course)
        }.to change(Course, :count).by(1)       
        expect(response).to redirect_to course_path(assigns[:course])
      end

      it "sends an email" do
        user = FactoryGirl.create(:user)

        sign_in user

        expect {
          post :create, course: FactoryGirl.attributes_for(:course)
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "attributes are invalid" do
      it "doesn't create a new course" do
        user = FactoryGirl.create(:user)

        sign_in user

        expect {
          post :create, course: FactoryGirl.attributes_for(:invalid_course)
        }.to change(Course, :count).by(0)
        expect(response).to render_template(:new)
      end

      it "doesn't send an email" do
        user = FactoryGirl.create(:user)

        sign_in user

        expect {
          post :create, course: FactoryGirl.attributes_for(:invalid_course)
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end

  describe "GET #edit" do
    context "user created the course" do
      it "renders edit template" do
        user = FactoryGirl.create(:user)        
        course = FactoryGirl.create(:course, user_id: user.id)

        sign_in user
        get :edit, id: course.id

        expect(response).to render_template(:edit)
      end 
    end

    context "user didn't create the course" do
      it "redirects the user to courses_path" do
        user = FactoryGirl.create(:user)    
        course = FactoryGirl.create(:course, user_id: user.id + 1)

        sign_in user
        get :edit, id: course.id

        expect(response).to redirect_to courses_path
      end
    end
  end

  describe "PATCH #update" do
    context "attributes are valid" do
      it "updates the course" do
        user = FactoryGirl.create(:user)   
        course = FactoryGirl.create(:course, user_id: user.id) 

        sign_in user
        patch :update, id: course.id, course: FactoryGirl.attributes_for(:course, title: "New Title!")
        course.reload
        
        expect(course.title).to eq("New Title!")
      end
    end

    context "attributes are invalid" do
      it "doesn't update the course" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id) 

        sign_in user   
        patch :update, id: course.id, course: FactoryGirl.attributes_for(:invalid_course, title: "New Title!")
        course.reload
        
        expect(course.title).to_not eq("New Title!")
      end
    end

  end

end
