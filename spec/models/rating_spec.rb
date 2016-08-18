require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe "#update_average_rating!" do
    it "should update the rating of the course after commit" do
      user = FactoryGirl.create(:user)
      course = FactoryGirl.create(:course, user_id: user.id + 1)
      rating = FactoryGirl.create(:rating, user_id: user.id, course_id: course.id)

      rating = FactoryGirl.build(:rating, user_id: 1, course_id: course.id, stars: 1)
      rating.save!
      course.reload

      expect(course.average_rating).to eq(3)
    end
  end
end
