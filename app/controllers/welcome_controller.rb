class WelcomeController < ApplicationController



	def index
		@love_letter = LoveLetter.all
		@love_letter_amount = @love_letter.count
	end

end
