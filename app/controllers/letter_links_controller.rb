class LetterLinksController < ApplicationController

	http_basic_authenticate_with name: "craig", password: "letters", except: [:show, :sent_letters, :error]

	def sent_letters
		@letter_link = LetterLink.where("token = ?", params[:link_token]).take

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:link_token])
		end


		@letter = Letter.where("link_token = ?", params[:link_token])



	end

	def error
		@letter_link = LetterLink.new
		@letter_link.token = params[:id]
		@letter_link.numLetters = 1
	end


	def index
		@letter_link = LetterLink.all
	end

	def show
		@letter_link = LetterLink.where("token = ?", params[:id]).take

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:id])
		end
	end

	def new
		@letter_link = LetterLink.new
	end

	def edit
		@letter_link = LetterLink.find(params[:id])
	end

	def create
		@letter_link = LetterLink.new(letter_link_params)
		@letter_link.token = SecureRandom.hex

		@letter_link.save
		redirect_to letter_links_path
	end

	def update
		@letter_link = LetterLink.find(params[:id])

		if @letter_link.update(letter_link_params)
			redirect_to letter_links_path
		else
			render 'edit'
		end
	end

	def destroy
		@letter_link = LetterLink.find(params[:id])
		@letter_link.destroy

		redirect_to letter_links_path
	end

	private
	def letter_link_params
		params.require(:letter_link).permit(:numLetters)
	end
end
