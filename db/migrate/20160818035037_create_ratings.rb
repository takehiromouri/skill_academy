class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :stars
      t.text :comment
      t.timestamps null: false
    end
    add_index :ratings, :user_id
  end
end
