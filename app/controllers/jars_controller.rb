class JarsController < ApplicationController

    def show
        @user = User.find_by(username: params[:user_username])
        @jar = @user.jars.find_by(site_url: params[:site_url])
        @letter = @jar.letters
    end


    def create
        @user = User.find_by(username: params[:user_username])
        @jar = @user.jars.new(jar_params)
		@jar.unlock_time = Time.now

		if @jar.save
			flash[:success] = "Jar created"
    	    redirect_to user_path(@user)
		else
            flash[:success] = "Jar not created"
			redirect_to user_path(@user)
		end
    end

    def destroy
        @user = User.find_by(username: params[:user_username])
        @jar = @user.jars.find_by(site_url: params[:site_url])
        @jar.destroy
        redirect_to user_path(@user)
    end
 
    private
    def jar_params
      params.require(:jar).permit(:site_url, :refresh_rate)
    end


end
