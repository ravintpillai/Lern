require 'matrix'

class ResultsController < ApplicationController

	def new
		@datafile = DataFile.find(params[:id])
		path = @datafile.path
		@result = normal_equation(analyze(path))
		render :new
	end

	def create
		result = Result.new({:coefficient => params[:coefficient], :intercept => params[:intercept], :data_file_id => params[:dfid]})
		result.save
		redirect_to root_path
	end

	def show
	end


	private

		def analyze(path)
			file = File.open(path,'rb')
			long_version = file.read
			file_split_by_line = long_version.split "\r"
			puts file_split_by_line.class
			independents = []
			dependents = []
			count = 0
			file_split_by_line.each do |kl|
			  fl = kl.split(",")
			  fl.each do |fkl|
			    count +=1
			    if (count%2) > 0
			      independents << fkl.to_i
			    else
			      dependents << fkl.to_i
			    end
			  end
			end

			return [independents,dependents]
		end

		def normal_equation(training_examples)
			independents = training_examples[0]
			dependents = training_examples[1]
			independent_parameter_name = independents.shift
			dependent_parameter_name = dependents.shift
			ones = Array.new(independents.length, 1)
			theta_vector = Matrix.row_vector(ones)
			theta_matrix = Matrix.rows(theta_vector.to_a << dependents)
			theta_matrix = theta_matrix.transpose
			y_vector = Matrix.row_vector(independents).transpose
			result_matrix = (((theta_matrix.transpose * theta_matrix).inverse)*theta_matrix.transpose*y_vector)
		end
end
