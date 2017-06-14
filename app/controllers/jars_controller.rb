class JarsController < ApplicationController

    def show
        @user = User.find(params[:user_id])
        @jar = @user.jars.find(params[:id])
        @letter = @jar.letters
    end


    def create
        @user = User.find(params[:user_id])
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
        @user = User.find(params[:user_id])
        @jar = @user.jars.find(params[:id])
        @jar.destroy
        redirect_to user_path(@user)
    end
 
    private
    def jar_params
      params.require(:jar).permit(:site_url, :refresh_rate)
    end


end
