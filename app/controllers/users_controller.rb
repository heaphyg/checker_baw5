class UsersController < ApplicationController

	def index
		@user = User.find(session[:user_id])
		render "index"
	end


	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id
			redirect_to users_path
		else
			redirect_to root_path
		end
	end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end