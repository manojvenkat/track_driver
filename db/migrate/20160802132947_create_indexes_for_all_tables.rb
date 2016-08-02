class CreateIndexesForAllTables < ActiveRecord::Migration
  def change
  	add_index :tenants, :name

  	add_index :vehicles, :tenant_id

  	add_index :drivers, :tenant_id

  	add_index :daily_scores, :driver_id
  	add_index :daily_scores, :vehicle_id
  	add_index :daily_scores, :driving_date
  end
end
