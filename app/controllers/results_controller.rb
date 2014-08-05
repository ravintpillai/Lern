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
			independents = []
			dependents = []
			file_split_by_line.each do |training_example|
				example_dependents = []
				parameter_number = 0
			  list_of_parameters = training_example.split(",")
			  list_of_parameters.each do |parameter|
			    parameter_number +=1
			    if parameter_number == 1
			      independents << parameter.to_i
			    else
			      example_dependents << parameter.to_i
			    end
			  end
			  dependents << example_dependents
			end
			puts "and the dependents are "
			puts dependents
			puts "and the dependents length is "
			puts dependents.length
			return [independents,dependents]
		end

		def normal_equation(training_examples)
			independents = training_examples[0]
			dependents = training_examples[1]
			independent_parameter_name = independents.shift
			dependent_parameter_name = dependents.shift
			ones = Array.new(independents.length, 1)
			theta_matrix = Matrix.row_vector(ones)
			theta_matrix_as_array = []
			puts "dependents length is #{dependents.length}"
			(0..dependents[0].length-1).each do |parameter_index|
				param_vec = []
				dependents.each do |dependent_paramater_vector|
					param_vec << dependent_paramater_vector[parameter_index]
				end
				theta_matrix_as_array << param_vec
				puts 'param vev is'
				puts param_vec
			end
			puts "theta matrix as array is #{theta_matrix_as_array.length}"
			puts theta_matrix_as_array
			theta_matrix_as_array.each do |parameter_array|
				theta_matrix = Matrix.rows(theta_matrix.to_a << parameter_array)
			end
			theta_matrix = theta_matrix.transpose
			y_vector = Matrix.row_vector(independents).transpose
			puts 'theta_matrix is'
			theta_matrix
			puts 'y vector is'
			puts y_vector
			result_matrix = (((theta_matrix.transpose * theta_matrix).inverse)*theta_matrix.transpose*y_vector)
			puts 'result matrix is'
			puts result_matrix
			result_matrix
		end
end
