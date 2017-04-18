class WelcomeController < ApplicationController
	def index





	end

	def startHomeScreen
		inputvalue = params[:value]

		if inputvalue == "Craig"
			redirect_to @love_letter
		else 
			redirect_to @letter_viewer

	end


end
