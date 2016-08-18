class AddCourseIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :course_id, :integer
    add_index :ratings, :course_id
  end
end
