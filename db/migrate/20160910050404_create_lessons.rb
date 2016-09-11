class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :section_id
      t.text :content
      t.integer :row_order
      t.timestamps null: false
    end
    add_index :lessons, :row_order
    add_index :lessons, :section_id
  end
end
