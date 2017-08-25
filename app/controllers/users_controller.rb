class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find_by(username: params[:username])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find_by(username: params[:username])
	end

	def create
		@user = User.new(user_params)

		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to user_path(@user.username)
		else 
			render 'new'
		end
	end

	def update
		@user = User.find_by(username: params[:username])

		if @user.update(user_params)
			redirect_to users_path
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find_by(username: params[:username])
		@user.destroy

		redirect_to users_path
	end

	private
	def user_params
		params.require(:user).permit(:id, :email, :password, :password_confirmation)
	end

	def to_param
		username
	end

end
