class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, :course_id, presence: true
  validates_uniqueness_of :user_id, scope: :course_id
end
