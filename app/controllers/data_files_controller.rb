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

    tmp = safe_data[:raw].tempfile
    FileUtils.cp(tmp.path, "#{Rails.root}/public/#{safe_data[:raw].original_filename}")

    flash.now[:success]="Great Success"

    @data_file = current_user.data_files.build({path: "#{Rails.root}/public/#{safe_data[:raw].original_filename}"})
    @data_file.save
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
