class LettersController < ApplicationController


	http_basic_authenticate_with name: "craig", password: "letters", except: [:show, :show_archived, :new_link_letter, :create_link_letter]
	http_basic_authenticate_with name: "eleanor", password: "present", only: [:show, :show_archived]

	def index
		@letter = Letter.all
	end

	def show

		@letter = Letter.find(params[:id])

		@mainUnlockTimeHolder = UnlockTimeHolder.first

		if @mainUnlockTimeHolder.nil?
			@mainUnlockTimeHolder = UnlockTimeHolder.new(unlockTime: Time.now)
			@mainUnlockTimeHolder.save
		end

		@unlockTime = @mainUnlockTimeHolder.unlockTime

		if Time.now > @unlockTime
			@newUnlockTime = @unlockTime + 48.hours #Should be Unlock Time
			@mainUnlockTimeHolder.update(unlockTime: @newUnlockTime)
			@canView = true
			@letter.isArchived = true
			@letter.save
		else
			@canView = false
		end

	end

	def show_archived
		@letter = Letter.find(params[:id])

		if @letter.isArchived
			@canView = true
		else 
			@canView = false
		end

	end


	def new
		@letter = Letter.new
	end

	def edit
		@letter = Letter.find(params[:id])
	end

	
	def create
		@letter = Letter.new(letter_params)
		@letter.isArchived = false
		@letter.link_token = "admin-created"

		@letter.save
		redirect_to letters_path
	end

	def new_link_letter
		@letter_link = LetterLink.where("token = ?", params[:link_token]).take

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:link_token])
		end

		@letter = Letter.new
	end

	def create_link_letter
		@letter_link = LetterLink.where("token = ?", params[:link_token]).take

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:link_token])
		end


		@letter_link.numLetters = @letter_link.numLetters - 1
		@letter_link.save

		@letter = Letter.new(letter_params)
		@letter.isArchived = false
		@letter.link_token = @letter_link.token
		@letter.save

		
		redirect_to letter_link_path(@letter_link.token)

	end

	def update
		@letter = Letter.find(params[:id])

		if @letter.update(letter_params)
			redirect_to letters_path
		else
			render 'edit'
		end
	end

	def unarchive
		@letter = Letter.find(params[:id])
		@letter.isArchived = false
		@letter.save
		redirect_to letters_path
	end

	def archive
		@letter = Letter.find(params[:id])
		@letter.isArchived = true
		@letter.save
		redirect_to letters_path
	end


	def destroy
		@letter = Letter.find(params[:id])
		@letter.destroy

		redirect_to letters_path
	end

	private
	def letter_params
		params.require(:letter).permit(:from, :title, :text, :colour)
	end
end
