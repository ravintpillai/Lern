class DataFilesController < ApplicationController

	def index
	end

	def new
		@data_file = DataFile.new()
	end

	def create
		@data_file = DataFile.new(:csv)
	end

	def show
	end

	def index
	end

end