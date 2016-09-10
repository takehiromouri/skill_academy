require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#name" do
    it "returns the full name" do
      user = FactoryGirl.create(:user, first_name: "First", last_name: "Last")

      expect(user.name).to eq("First Last")
    end
  end

  describe "#enrolled_in" do
    context "user is enrolled in the course" do
      it "returns true" do
        user = FactoryGirl.create(:user)
        instructor = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: instructor.id)
        FactoryGirl.create(:enrollment, user_id: user.id, course_id: course.id)

        expect(user.enrolled_in?(course)).to eq(true)
      end
    end

    context "user is not enrolled in the course" do
      it "returns false" do
        user = FactoryGirl.create(:user)
        instructor = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: instructor.id)

        expect(user.enrolled_in?(course)).to eq(false)
      end
    end
  end
end