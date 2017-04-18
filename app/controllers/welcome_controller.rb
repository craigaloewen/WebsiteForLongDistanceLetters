class WelcomeController < ApplicationController
  def index
  	
  	if !(session[:value])
  		session[:value] = 1
  	else 
  		session[:value] = 5

  	render :text => session[:value]

  	

  end


end
