class AddEnrollmentCounts < ActiveRecord::Migration
  def change
    remove_column :courses, :enrollment_count
    add_column :courses, :enrollments_count, :integer
  end
end
