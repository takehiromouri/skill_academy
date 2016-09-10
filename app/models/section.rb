class Section < ActiveRecord::Base
  belongs_to :course
  has_many :lessons

  validates :title, :course_id, presence: true

  def first_lesson
    lessons.order(:id).first
  end

  def next
    course.sections.where("id > ?", self.id).first
  end
end
