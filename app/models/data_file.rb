class DataFile < ActiveRecord::Base
  belongs_to :user
  has_one :result
  has_attached_file :raw, :path => "/data/:id/:filename"
  validates_attachment_content_type :raw, :content_type => ["text/csv"]
end
