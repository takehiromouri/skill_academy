require 'elasticsearch/model'

class Course < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Filterable
  include Sortable

  is_impressionable
  
  validates :title, :description, :price, :category, :user_id, presence: true
  validates :price, numericality: { greater_than: -1 }

  belongs_to :instructor, class_name: "User", foreign_key: :user_id
  has_many :enrollments
  has_many :ratings
  has_many :sections
  has_many :lessons, through: :sections

  delegate :name, to: :instructor, prefix: true

  enum category: [:Business, :Programming, :Design, :Excel, :Presentations]

  scope :sort_by_column, -> (sort_by_column) { order("#{sort_by_column} DESC") }
  scope :category, -> (category) { where(category: categories[category]) }

  SORTABLE = {
    :price => "Price", 
    :created_at => "Posted", 
    :average_rating => "Average Rating",
    :start_time => "Start Time",
    :impressionist_count => "Views",
    :enrollments_count => "Enrollments"
  }

  mount_uploader :photo, PhotoUploader

  def course_location
    location.blank? ? "Online" : location
  end

  def course_address
    address.blank? ? "Online" : location
  end

  def start
    if start_time.blank?
      "Ongoing"
    else
      start_time.in_time_zone.strftime("%m/%d/%Y %l:%M %p")
    end
  end

  def end
    if end_time.blank?
      "Ongoing"
    else
      end_time.in_time_zone.strftime("%m/%d/%Y %l:%M %p")
    end
  end

  def self.search(*args)
    __elasticsearch__.search(*args)
  end
end
