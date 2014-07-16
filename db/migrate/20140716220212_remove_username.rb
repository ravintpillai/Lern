class RemoveUsername < ActiveRecord::Migration
  def change
  	remove_column :user, :username
  end
end
