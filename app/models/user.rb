class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :courses
  has_many :ratings
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  

  mount_uploader :photo, PhotoUploader

  def name
    self.first_name + " " + self.last_name
  end

  def enrolled?(course)
    return true if Enrollment.where(course_id: course.id, user_id: self.id)
    false
  end
end
