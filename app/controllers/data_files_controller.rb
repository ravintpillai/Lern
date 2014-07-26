require 'fileutils'
class DataFilesController < ApplicationController

	def index
	end

	def new
    if user_signed_in?
      render :new
    else
      redirect_to "users/sign_up"
    end
	end

	def create
    Rails.logger.info "Ravin, it's a #{safe_data[:csv].class}"

    tmp = safe_data[:csv].tempfile
    FileUtils.cp(tmp.path, "#{Rails.root}/public/#{safe_data[:csv].original_filename}")

    flash.now[:success]="Great Success"

    @data_file = DataFile.new({path: "#{Rails.root}/public/#{safe_data[:csv].original_filename}"})
    @data_file.save
    render :new
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
