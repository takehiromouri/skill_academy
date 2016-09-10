require 'rails_helper'

RSpec.describe Section, type: :model do
  describe "#first_lesson" do
    context "section has a lesson" do
      it "returns first lesson in section" do
        build_course
        first_lesson = FactoryGirl.create(:lesson, section_id: @section.id)
        second_lesson = FactoryGirl.create(:lesson, section_id: @section.id, id: first_lesson.id + 1)

        expect(@section.first_lesson).to eq(first_lesson)
      end
    end

    context "section does not have lesson" do
      it "returns nil" do
        build_course

        expect(@section.first_lesson).to eq(nil)
      end
    end
  end

  describe "#next" do
    context "there is next section" do
      it "returns next section" do
        build_course
        next_section = FactoryGirl.create(:section, course_id: @course.id, id: @section.id + 1)
        next_section_2 = FactoryGirl.create(:section, course_id: @course.id, id: @section.id + 2)

        expect(@section.next).to eq(next_section)
      end
    end

    context "there is no next section" do
      it "returns nil" do
        build_course

        expect(@section.next).to eq(nil)
      end
    end
  end

  describe "#previous" do
    context "there is previous section" do
      it "returns previous section" do
        build_course
        previous_section = FactoryGirl.create(:section, course_id: @course.id, id: @section.id - 1)
        previous_section_2 = FactoryGirl.create(:section, course_id: @course.id, id: @section.id - 2)

        expect(@section.previous).to eq(previous_section)
      end
    end

    context "there is no previous section" do
      it "returns nil" do
        build_course

        expect(@section.previous).to eq(nil)
      end
    end
  end

  def build_course
    @user = FactoryGirl.build_stubbed(:user)
    @course = FactoryGirl.create(:course, user_id: @user.id)
    @section = FactoryGirl.create(:section, course_id: @course.id)
  end
end


