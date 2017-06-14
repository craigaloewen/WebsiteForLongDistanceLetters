class LettersController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter = @jar.letters
	end

	def show
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter = @jar.letters.find(params[:id])


		
		if Time.now > @jar.unlock_time
			@canView = true
			@letter.is_archived = true
			@letter.save
		else
			@canView = false
		end

	end

	def show_archived
		@letter = Letter.find(params[:id])

		if @letter.is_archived
			@canView = true
		else 
			@canView = false
		end

	end


	def new
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter = @jar.letters.new
	end

	def edit
		@letter = Letter.find(params[:id])
	end

	
	def create
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter = @jar.letters.new(letter_params)
		@letter.is_archived = false
		@letter.link_token = "admin-created"
		
		if @letter.save
			flash[:success] = "Letter created"
			redirect_to user_jar_letters_path(@user,@jar)
		else
			render 'new'
		end
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


		@letter_link.letters_number = @letter_link.letters_number - 1
		@letter_link.save

		@letter = Letter.new(letter_params)
		@letter.is_archived = false
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
		@letter.is_archived = false
		@letter.save
		redirect_to letters_path
	end

	def archive
		@letter = Letter.find(params[:id])
		@letter.is_archived = true
		@letter.save
		redirect_to letters_path
	end


	def destroy
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter = @jar.letters.find(params[:id])
		@letter.destroy

		redirect_to user_jar_letters_path(@user,@jar)
	end

	private
	def letter_params
		params.require(:letter).permit(:from, :title, :text, :colour)
	end
end
