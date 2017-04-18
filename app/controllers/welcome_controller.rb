class WelcomeController < ApplicationController
  def index
  	
  	if !(session[:value]) then session[:value] = 1

  	session[:value] = session[:value] + 1


  	render :text => session[:value]

  	

  end


end
