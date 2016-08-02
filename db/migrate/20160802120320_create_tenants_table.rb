class CreateTenantsTable < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :city

      t.timestamps null: false        
    end
  end
end
