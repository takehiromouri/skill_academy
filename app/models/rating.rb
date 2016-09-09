class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, :course_id, :stars, presence: true
  validates :course_id, uniqueness: { scope: :user_id }

  delegate :photo, to: :user, prefix: true
  delegate :name, to: :user, prefix: true

  after_create :update_average_rating!

  STARS = {
    "☆☆☆☆☆" => 5,
    "☆☆☆☆" => 4,
    "☆☆☆" => 3,
    "☆☆" => 2,
    "☆" => 1
  }


  def update_average_rating!
    rating_count = course.ratings.count    
    new_average = (self.course.average_rating * (rating_count.to_f - 1) + self.stars) / rating_count.to_f

    self.course.update(average_rating: new_average)
  end

end
