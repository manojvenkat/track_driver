class CreateVehiclesDrivers < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :registration, null: false, unique: true
      t.references :tenant, null: false

      t.timestamps null: false
    end

    create_table :drivers do |t|
      t.string :license_id, null: false, unique: true    
      t.references :tenant, null: false

      t.timestamps null: false
    end
  end
end
