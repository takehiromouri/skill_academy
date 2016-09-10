class CreateSections < ActiveRecord::Migration
  def change
    drop_table :sections
    create_table :sections do |t|
      t.string :title
      t.integer :course_id
      t.timestamps null: false
    end
    add_index :sections, :course_id
  end
end
