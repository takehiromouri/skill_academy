class Course < ActiveRecord::Base
  validates :title, :description, :price, :start_time, :end_time, :category, :user_id, :location, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :user
  has_many :enrollments

  enum category: [:Business, :Programming, :Design, :Excel, :Presentations]

  mount_uploader :photo, PhotoUploader
end
