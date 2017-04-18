class LoveLettersController < ApplicationController
	
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end


	def new
	end

	
	def create
		@love_letter = LoveLetter.new(love_letter_params)

		@love_letter.save
		redirect_to @love_letter
	end

	private
	def love_letter_params
		params.require(:love_letter).permit(:title, :text)
	end
end
