class LetterLinksController < ApplicationController

	def sent_letters
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = @jar.letter_links.where("token = ?", params[:letter_link_id]).take

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:link_token])
		end


		@letter = @jar.letters.where("link_token = ?", params[:link_token])
	end

	def error

	end

	def index
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = @jar.letter_links
	end

	def show
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = @jar.letter_links.where("token = ?", params[:id]).take

		if @letter_link.nil?
			redirect_to error_user_jar_letter_link_path(@user,@jar,params[:id])
		end
	end

	def new
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = LetterLink.new
	end

	def edit
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = LetterLink.find(params[:id])
	end

	def create
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = @jar.letter_links.new(letter_link_params)
		@letter_link.token = SecureRandom.hex
		if @letter_link.save
			flash[:success] = "Letter Link created"
    	    redirect_to user_jar_letter_links_path(@user,@jar)
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = LetterLink.find(params[:id])

		if @letter_link.update(letter_link_params)
			redirect_to user_jar_letter_links_path(@user, @jar)
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@jar = Jar.find(params[:jar_id])
		@letter_link = LetterLink.find(params[:id])
		@letter_link.destroy

		redirect_to user_jar_letter_links_path(@user, @jar)
	end

	private
	def letter_link_params
		params.require(:letter_link).permit(:letters_number)
	end
end
