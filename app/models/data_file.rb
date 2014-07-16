class DataFile < ActiveRecord::Base

	def self.save(upload)
		name = upload['datafile'].original_filename
		directory = "public/data"
		path = File.join(diectory, name)
		File.open(path,"wb") { |f| f.write(upload['datafile'].read) }
	end
end
