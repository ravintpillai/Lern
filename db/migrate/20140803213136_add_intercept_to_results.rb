class AddInterceptToResults < ActiveRecord::Migration
  def change
    add_column :results, :intercept, :float
  end
end
