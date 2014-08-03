class DataFile < ActiveRecord::Base
  belongs_to :user
  has_one :result
end
