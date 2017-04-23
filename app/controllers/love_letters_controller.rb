class LoveLettersController < ApplicationController


	http_basic_authenticate_with name: "craig", password: "letters", except: [:show]

	def no_access

	end

	def index
		@love_letter = LoveLetter.all
	end

	def show

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
		else
			@canView = false
		end

		


		@love_letter = LoveLetter.find(params[:id])
	end


	def new
		@love_letter = LoveLetter.new
	end

	def edit
		@love_letter = LoveLetter.find(params[:id])
	end

	
	def create
		@love_letter = LoveLetter.new(love_letter_params)
		@love_letter.isArchived = false

		@love_letter.save
		redirect_to love_letters_path
	end

	def update
		@love_letter = LoveLetter.find(params[:id])

		if @love_letter.update(love_letter_params)
			redirect_to love_letters_path
		else
			render 'edit'
		end
	end


	def destroy
		@love_letter = LoveLetter.find(params[:id])
		@love_letter.destroy

		redirect_to love_letters_path
	end

	private
	def love_letter_params
		params.require(:love_letter).permit(:title, :text, :colour)
	end
end
