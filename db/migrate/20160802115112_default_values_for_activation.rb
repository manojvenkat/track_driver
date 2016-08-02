class DefaultValuesForActivation < ActiveRecord::Migration
  def change
  	change_column :users, :activated, :boolean, default: true
  	change_column :users, :activated_at, :datetime, default: Time.now
  end
end
