class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.datetime :start_time
      t.datetime :end_time
      t.integer :category
      t.integer :user_id
      t.text :target
      t.timestamps null: false
    end
    add_index :courses, :user_id
  end
end
