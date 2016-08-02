class AddMaxPointsToDailyScores < ActiveRecord::Migration
  def change
  	add_column :daily_scores, :max_score, :integer, null: false, default: 0
  end
end
