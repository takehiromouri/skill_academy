class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, :course_id, :stars, presence: true
  validates :course_id, uniqueness: { scope: :user_id }

  STARS = {
    5 => "☆☆☆☆☆",
    4 => "☆☆☆☆",
    3 => "☆☆☆",
    2 => "☆☆",
    1 => "☆"
  }
end
