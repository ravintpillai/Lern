class DataFilesController < ApplicationController

	def index
	end

	def new
		@data_file = DataFile.new()
	end

	def create
		@data_file = DataFile.new(safe_data)
		@data_file.save
		redirect_to @data_file
	end

	def show
	end

	def index
	end


	private

		def safe_data
			params.require('data_file').permit(:csv)
		end
end