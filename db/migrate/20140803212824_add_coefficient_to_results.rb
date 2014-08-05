class AddCoefficientToResults < ActiveRecord::Migration
  def change
  	add_column :results, :coefficient, :float
  end
end
