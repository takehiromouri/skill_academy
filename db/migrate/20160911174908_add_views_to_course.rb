class AddViewsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :views, :integer
  end
end
