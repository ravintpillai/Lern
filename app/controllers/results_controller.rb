class ResultsController < ApplicationController

	def new
		path = DataFile.find(params[:id]).path
		@result = analyze(path)
		render :new
	end

	def create
		path = DataFile.find(params[:id]).path
		result = analyze(path)
		puts result
	end

	def show
	end
end