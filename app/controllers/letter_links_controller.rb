class LetterLinksController < ApplicationController

	def sent_letters
		@letter_link = LetterLink.find_by(token: params[:letter_link_token])

		if @letter_link.nil?
			temp_letter_link = LetterLink.new
			temp_letter_link.token = params[:letter_link_token]
			redirect_to error_letter_link_path(temp_letter_link)
		end

		@jar = Jar.find(@letter_link.jar_id)	
		
		if @jar.nil?
			redirect_to error_letter_link_path(@letter_link)
		end

		@letter = @jar.letters.where("link_token = ?", params[:letter_link_token])
	end

	def error

	end

	def index
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter_links = @jar.letter_links
		check_admin_access(@jar)
	end

	def show
		@letter_link = LetterLink.find_by(token: params[:token])

		if @letter_link.nil?
			redirect_to error_jar_letter_link_path(@jar,params[:id])
		end
	end

	def new
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter_link = LetterLink.new
		check_admin_access(@jar)
	end

	def edit
		@user = User.find_by(username: params[:user_username])
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter_link = LetterLink.find(params[:id])
		check_admin_access(@jar)
	end

	def create
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter_link = @jar.letter_links.new(letter_link_params)
		@letter_link.token = SecureRandom.hex
		check_admin_access(@jar)
		if @letter_link.save
			flash[:success] = "Letter Link created"
    	    redirect_to jar_letter_links_path(@jar)
		else
			render 'new'
		end
	end

	def update
		@user = User.find_by(username: params[:user_username])
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter_link = LetterLink.find(params[:id])
		check_admin_access(@jar)

		if @letter_link.update(letter_link_params)
			redirect_to user_jar_letter_links_path(@user, @jar)
		else
			render 'edit'
		end
	end

	def destroy
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter_link = LetterLink.find_by(token: params[:token])
		check_admin_access(@jar)
		@letter_link.destroy

		redirect_to jar_letter_links_path(@jar)
	end

	private
	def letter_link_params
		params.require(:letter_link).permit(:letters_number)
	end

	def to_param
		token
	end

end
