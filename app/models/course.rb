require 'elasticsearch/model'

class Course < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  is_impressionable
  
  validates :title, :description, :price, :start_time, :end_time, :category, :user_id, :location, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :user
  has_many :enrollments
  has_many :ratings

  enum category: [:Business, :Programming, :Design, :Excel, :Presentations]

  mount_uploader :photo, PhotoUploader

  def self.search(*args)
    __elasticsearch__.search(*args)
  end
end
