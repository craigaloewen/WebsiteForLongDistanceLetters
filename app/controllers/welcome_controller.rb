class WelcomeController < ApplicationController
  def index
  	if !session[:viewNumber]
  		session[:viewNumber] = 0

  	session[:viewNumber] = session[:viewNumber] + 1

  end


end
