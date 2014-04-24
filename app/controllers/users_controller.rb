class UsersController < ApplicationController

	def index
		@user = User.find(session[:user_id])

		@users = User.all
		@game_room = GameRoom.new
		@rooms = GameRoom.all

		render "index"
	end


	def edit
		@user = User.find(params[:id])
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


	def show
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to users_path
		else
			render "edit"
		end
	end


	def destroy #deletes user's profile, clears session
		@user = User.find(params[:id])
		@user.destroy
		session.clear

		redirect_to root_path
	end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
