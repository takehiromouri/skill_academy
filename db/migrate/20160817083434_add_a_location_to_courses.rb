class AddALocationToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :location, :string
    add_column :courses, :address, :string
  end
end
