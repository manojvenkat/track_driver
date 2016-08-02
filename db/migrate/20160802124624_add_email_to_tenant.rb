class AddEmailToTenant < ActiveRecord::Migration
  def change
  	add_column :tenants, :email, :text
  end
end
