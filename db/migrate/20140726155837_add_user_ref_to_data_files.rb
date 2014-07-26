class AddUserRefToDataFiles < ActiveRecord::Migration
  def change
    add_reference :data_files, :user, index: true
  end
end
