class CreateDailyScores < ActiveRecord::Migration
  def change
    create_table :daily_scores do |t|
      t.references :driver, null: false
      t.references :vehicle, null: false
      t.integer :score
      t.datetime :driving_date

      t.timestamps null: false
    end
  end
end
