require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do

  describe "POST #create" do
    context "user created the course" do
      it "doesn't enroll the user" do
        user = FactoryGirl.create(:user)
        course = double("course")

        sign_in user

        expect(Course).to receive(:find).and_return(course)
        expect(course).to receive(:instructor).and_return(user)
        expect(course).to receive(:id).and_return(1)
        
        expect {
          post :create, course_id: course.id
        }.to change(Enrollment, :count).by(0)
      end
    end

    context "user didn't create the course" do
      context "user has not enrolled in the course" do
        it "enrolls the user" do
          user = FactoryGirl.create(:user)
          course = FactoryGirl.create(:course, user_id: user.id + 1)

          sign_in user

          expect {
            post :create, course_id: course.id
          }.to change(Enrollment, :count).by(1)
        end

        it "sends an email" do
          user = FactoryGirl.create(:user)
          course = FactoryGirl.create(:course, user_id: user.id + 1)

          sign_in user

          expect {
            post :create, course_id: course.id
          }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      context "user has already enrolled in the course" do
        it "doesn't enroll the user" do
          user = FactoryGirl.create(:user)
          course = FactoryGirl.create(:course, user_id: user.id)
          FactoryGirl.create(:enrollment, course_id: course.id, user_id: user.id)

          sign_in user

          expect {
            post :create, course_id: course.id
          }.to change(Enrollment, :count).by(0)
        end

        it "doesn't send an email" do
          user = FactoryGirl.create(:user)
          course = FactoryGirl.create(:course, user_id: user.id)
          FactoryGirl.create(:enrollment, course_id: course.id, user_id: user.id)

          sign_in user

          expect {
            post :create, course_id: course.id
          }.to change { ActionMailer::Base.deliveries.count }.by(0)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "user created enrollment" do
      it "should delete enrollment" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)
        enrollment = FactoryGirl.create(:enrollment, course_id: course.id, user_id: user.id)

        sign_in user

        expect {
          delete :destroy, course_id: course.id, id: enrollment.id
        }.to change(Enrollment, :count).by(-1)
      end
    end

    context "user did not create enrollment" do
      it "shouldn't delete enrollment" do
        user = FactoryGirl.create(:user)
        course = FactoryGirl.create(:course, user_id: user.id + 1)
        enrollment = FactoryGirl.create(:enrollment, course_id: course.id, user_id: user.id + 1)

        sign_in user

        expect {
          delete :destroy, course_id: course.id, id: enrollment.id
        }.to change(Enrollment, :count).by(0)
      end
    end
  end
end
