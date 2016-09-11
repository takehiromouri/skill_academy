require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "#course_location" do
    context "location is blank" do
      it "displays Online" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, location: "")

        expect(course.course_location).to eq("Online")
      end
    end

    context "location is nil" do
      it "displays Online" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, location: nil)

        expect(course.course_location).to eq("Online")
      end
    end

    context "location is present" do
      it "displays location" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, location: "Location")

        expect(course.course_location).to eq("Location")
      end
    end
  end

  describe "#course_address" do
    context "address is blank" do
      it "displays Online" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, address: "")

        expect(course.course_address).to eq("Online")
      end
    end

    context "location is nil" do
      it "displays Online" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, address: nil)

        expect(course.course_address).to eq("Online")
      end
    end

    context "address is present" do
      it "displays address" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, address: nil)

        expect(course.course_address).to eq("Online")
      end
    end
  end

  describe "#start_time" do
    context "start_time is nil" do
      it "returns Ongoing" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, start_time: nil, end_time: nil)

        expect(course.start).to eq("Ongoing")
      end
    end

    context "start_time is not nil" do
      it "displays the start_time" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, start_time: DateTime.now, 
                                                               end_time: DateTime.now + 5.days)

        expect(course.start).to eq(DateTime.now.in_time_zone.strftime("%m/%d/%Y %l:%M %p"))
      end
    end
  end

  describe "#end_time" do
    context "end_time is nil" do
      it "returns Ongoing" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, start_time: nil, end_time: nil)

        expect(course.end).to eq("Ongoing")
      end
    end

    context "end_time is not nil" do
      it "displays the end_time" do
        user = FactoryGirl.build_stubbed(:user)
        course = FactoryGirl.create(:course, user_id: user.id, start_time: DateTime.now, 
                                                               end_time: DateTime.now + 5.days)

        expect(course.end).to eq((DateTime.now + 5.days).in_time_zone.strftime("%m/%d/%Y %l:%M %p"))
      end
    end
  end
end
