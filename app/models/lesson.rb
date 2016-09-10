class Lesson < ActiveRecord::Base
  belongs_to :section
  has_one :course, through: :section

  validates :title, :section_id, :content, presence: true

  def next
    section.lessons.where("id > ?", self.id).first
  end

  def previous
    section.lessons.where("id < ?", self.id).last
  end
end
