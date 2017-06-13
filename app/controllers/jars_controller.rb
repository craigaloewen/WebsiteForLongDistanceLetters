class JarsController < ApplicationController

    def show
        @user = User.find(params[:user_id])
        @jar = @user.jars.find(params[:id])
        @letter = @jar.letters
    end


    def create
        @user = User.find(params[:user_id])
        @jar = @user.jars.create(jar_params)
        redirect_to user_path(@user)
    end

    def destroy
        @user = User.find(params[:user_id])
        @jar = @user.jars.find(params[:id])
        @jar.destroy
        redirect_to user_path(@user)
    end
 
    private
    def jar_params
      params.require(:jar).permit(:siteurl)
    end


end
