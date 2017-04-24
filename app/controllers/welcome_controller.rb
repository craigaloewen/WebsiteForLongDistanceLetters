class WelcomeController < ApplicationController



	def index
		@letter = Letter.where(isArchived: false)
		@letter_amount = @letter.count
	end

end
