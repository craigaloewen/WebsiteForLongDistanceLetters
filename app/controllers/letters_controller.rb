class LettersController < ApplicationController


	http_basic_authenticate_with name: "craig", password: "letters", except: [:show]

	def index
		@letter = Letter.all
	end

	def show

		@letter = Letter.find(params[:id])

		@unlock_time_holder = UnlockTimeHolder.all

		if @unlock_time_holder.count < 1
			@unlock_time_holder_new = UnlockTimeHolder.new(unlockTime: Time.now)
			@unlock_time_holder_new.save
		end

		@mainUnlockTimeHolderArray = UnlockTimeHolder.limit(1)
		@mainUnlockTimeHolder = @mainUnlockTimeHolderArray[0]
		@unlockTime = @mainUnlockTimeHolder.unlockTime

		@canView

		if Time.now > @unlockTime
			@newUnlockTime = Time.now + 10.seconds #Should be Unlock Time
			@mainUnlockTimeHolder.update(unlockTime: @newUnlockTime)
			@canView = true
			@letter.isArchived = true
			@letter.save
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

		@letter.save
		redirect_to letters_path
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


	def destroy
		@letter = Letter.find(params[:id])
		@letter.destroy

		redirect_to letters_path
	end

	private
	def letter_params
		params.require(:letter).permit(:title, :text, :colour)
	end
end
