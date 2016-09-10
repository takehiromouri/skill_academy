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

  def enrolled_in?(course)
    enrollments.where(course: course).present?
  end

  def name
    self.first_name + " " + self.last_name
  end
end
