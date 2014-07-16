class RemoveUsernameFromUser < ActiveRecord::Migration
  def change
  end

  def up
  	remove_column :user, :username
  end

  def down
  	add_column :user, :username
  end
end
