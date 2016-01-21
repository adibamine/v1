class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@voitures = @user.voitures
	end
end