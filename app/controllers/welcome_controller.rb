class WelcomeController < ApplicationController
	def index





	end

	def startHomeScreen
		inputvalue = params[:value]

		render :text => inputvalue
		
	end


end
