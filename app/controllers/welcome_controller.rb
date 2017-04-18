class WelcomeController < ApplicationController
  def index
  	

  	session[:value] = 1

  	if session[:value]
  		render :text => session[:value]

  end


end
