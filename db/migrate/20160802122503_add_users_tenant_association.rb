class AddUsersTenantAssociation < ActiveRecord::Migration
  def change
  	add_reference :users, :tenant, index: true
  end
end
