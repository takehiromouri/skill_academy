class AddEnrollmentsCountToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :enrollment_count, :integer
  end
end
