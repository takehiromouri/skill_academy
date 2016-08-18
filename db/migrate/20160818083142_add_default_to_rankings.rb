class AddDefaultToRankings < ActiveRecord::Migration
  def change
    change_column :courses, :average_rating, :float, default: 0.0
  end
end
