class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(full_user)
		@user.save
		redirect_to @user
	end

	def show
		@user = User.find(params[:id])
	end

	def update
	end

	def edit
	end

	def index
		@users = User.all
	end

	private
		def full_user
			params.require('user').permit(:username, :email)
		end

end