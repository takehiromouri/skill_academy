require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe "#next" do
    context "there is a next lesson in current section" do
      it "returns the next lesson" do
        build_course
        next_lesson = FactoryGirl.create(:lesson, section_id: @section.id, id: @lesson.id + 1)

        expect(@lesson.next).to eq(next_lesson)
      end
    end

    context "there is no next lesson in current section" do
      it "returns nil" do
        build_course
        
        expect(@lesson.next).to eq(nil)
      end
    end
  end

  describe "#previous" do
    context "there is a previous lesson in current section" do
      it "returns the previous lesson" do
        build_course
        previous_lesson = FactoryGirl.create(:lesson, section_id: @section.id, id: @lesson.id - 1)

        expect(@lesson.previous).to eq(previous_lesson)
      end
    end

    context "there is no previous lesson in current section" do
      it "returns nil" do
        build_course
        
        expect(@lesson.previous).to eq(nil)
      end
    end
  end

  def build_course
    @user = FactoryGirl.build_stubbed(:user)
    @course = FactoryGirl.create(:course, user_id: @user.id)
    @section = FactoryGirl.create(:section, course_id: @course.id)
    @lesson = FactoryGirl.create(:lesson, section_id: @section.id)
  end
end


