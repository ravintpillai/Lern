class AddDataFileRefToResults < ActiveRecord::Migration
  def change
  	add_reference :results, :data_file, index: true
  end
end
