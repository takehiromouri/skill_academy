class Course < ActiveRecord::Base
  validates :title, :description, :price, :start_time, :end_time, :category, :user_id, presence: true
  validates :price, numericality: { greater_than: 0 }
end
