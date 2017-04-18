class WelcomeController < ApplicationController
  def index
  	
  	inputvalue = params[:value]

  	render :text => inputvalue



  end


end
