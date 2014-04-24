class SessionsController < ApplicationController


  def index
		if logged_in?

			@user = User.find(session[:user_id])
			redirect_to users_path
		else 
			@user = User.new
	  	render "index"
		end
	end

	def create

		@user = User.find_by(email: user_params[:email])
		if @user && @user.authenticate(user_params[:password])

			session[:user_id] = @user.id

			redirect_to users_path

		else
			redirect_to "index"
		end
	end


	def destroy
		session.clear
		redirect_to root_url
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
