class AddPhotoToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :photo, :string
  end
end
