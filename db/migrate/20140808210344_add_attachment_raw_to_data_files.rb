class AddAttachmentRawToDataFiles < ActiveRecord::Migration
  def self.up
    change_table :data_files do |t|
      t.attachment :raw
    end
  end

  def self.down
    remove_attachment :data_files, :raw
  end
end
