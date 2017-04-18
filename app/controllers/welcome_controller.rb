class WelcomeController < ApplicationController
	def index





	end

	def startHomeScreen
		inputvalue = params[:value]

		if inputvalue == "Craig"
			redirect_to @love_letters
		else
			render :text => inputvalue
		end

	end


end
