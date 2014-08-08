require 'fileutils'
class DataFilesController < ApplicationController

	def index
	end

	def new
    if user_signed_in?
      @data_file = DataFile.new
      render :new
    else
      redirect_to "users/sign_up"
    end
	end

	def create
    Rails.logger.info "Ravin, it's a #{safe_data[:raw].class}"
    flash.now[:success]="Great Success"
    @data_file = current_user.data_files.build(safe_data)
    @data_file.save
    @data_file.update_attributes(path: "https://s3-eu-west-1.amazonaws.com/thambapillailern/data/#{@data_file.id}/#{@data_file.raw_file_name}")
    redirect_to new_result_path(id: @data_file.id)
	end

	def show
	end

	def index
	end

	private

		def safe_data
			params.require('data_file').permit(:raw)
		end
end

"https://s3-eu-west-1.amazonaws.com/thambapillailern/data/#{}/timsdata.csv"
