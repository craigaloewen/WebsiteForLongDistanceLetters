class WelcomeController < ApplicationController
  def index
  	
  	session[:value] = 1

  	render :text => session[:value]

  	

  end


end
