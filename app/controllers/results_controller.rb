require 'matrix'

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


	private

		def analyze(path)
			file = File.open(path,'rb')
			long_version = file.read
			file_split_by_line = long_version.split "\r"
			puts file_split_by_line.class
			independents = []
			dependents = []
			count = 0
			puts "count = #{count}\n\n\n\n"
			file_split_by_line.each do |kl|
			  fl = kl.split(",")
			  fl.each do |fkl|
			    count +=1
			    if (count%2) > 0
			      puts "independent is #{fkl}"
			      independents << fkl.to_i
			    else
			      puts "dependent is #{fkl}"	
			      dependents << fkl.to_i
			    end
			  end
			end
			k = independents.shift
			y = dependents.shift
			puts "k = #{k}"
			puts "y = #{y}"
			puts dependents
			puts independents
			#puts independents
			ones = Array.new(independents.length, 1)
			mat = Matrix.row_vector(ones)
			#puts mat
			#puts mat.to_a
			mat = Matrix.rows(mat.to_a << dependents)
			mats = mat.transpose

			mat2 = Matrix.row_vector(independents).transpose
			puts mats
			puts mat2
			jkl = (((mats.transpose * mats).inverse)*mats.transpose*mat2)
		end
end