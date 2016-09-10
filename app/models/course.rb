require 'elasticsearch/model'

class Course < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  is_impressionable
  
  validates :title, :description, :price, :start_time, :end_time, :category, :user_id, :location, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :instructor, class_name: "User", foreign_key: :user_id
  has_many :enrollments
  has_many :ratings
  has_many :sections
  has_many :lessons, through: :sections

  delegate :name, to: :instructor, prefix: true

  enum category: [:Business, :Programming, :Design, :Excel, :Presentations]

  SORTABLE = {
    :price => "Price", 
    :created_at => "Posted", 
    :average_rating => "Average Rating",
    :start_time => "Start Time",
    :views => "Views"
  }

  mount_uploader :photo, PhotoUploader

  def self.search(*args)
    __elasticsearch__.search(*args)
  end
end
