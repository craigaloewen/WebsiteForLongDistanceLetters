class LettersController < ApplicationController

	def index
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = @jar.letters
		check_admin_access(@jar)
	end

	def show
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = @jar.letters.find(params[:id])
		
		if Time.now > @jar.unlock_time
			@canView = true
			@letter.is_archived = true

			remove_letter_count_helper(@jar)

			if !@letter.save
				flash[:warning] = "Unable to save letter"
				redirect_to jar_path(@jar)
			end
		else
			@canView = false
		end
	end

	def show_archived
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = Letter.find(params[:id])

		if @letter.is_archived
			@canView = true
		else 
			@canView = false
		end

	end

	def new
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = @jar.letters.new
		check_admin_access(@jar)
	end

	def edit
		@jar = Jar.find_by(site_url: params[:jar_site_url])		
		@letter = Letter.find(params[:id])
		check_admin_access(@jar)
	end

	def create
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = @jar.letters.new(letter_params)
		@letter.is_archived = false
		@letter.link_token = "admin-created"
		check_admin_access(@jar)
		
		if @letter.save
			flash[:success] = "Letter created"
			redirect_to admin_jar_path(@jar)
		else
			render 'new'
		end
	end

	def new_link_letter
		@letter_link = LetterLink.find_by(token: params[:letter_link_token])

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:letter_link_token])
		end

		@letter = Letter.new
	end

	def create_link_letter
		@letter_link = LetterLink.find_by(token: params[:letter_link_token])
		@jar = Jar.find(@letter_link.jar_id)

		if @letter_link.nil?
			redirect_to error_letter_link_path(params[:link_token])
		end

		@letter = Letter.new(letter_params)
		@letter.is_archived = false
		@letter.link_token = @letter_link.token
		@letter.jar_id = @letter_link.jar_id

		if @letter.save
			@letter_link.letters_number = @letter_link.letters_number - 1
			if !@letter_link.save
				flash[:warning] = "Letter Link Failed to save"
				render 'new_link_letter'
			end
			flash[:success] = "Letter created"
			redirect_to letter_link_path(@letter_link)
		else
			render 'new_link_letter'
		end
	end

	def update
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = Letter.find(params[:id])
		check_admin_access(@jar)

		if @letter.update(letter_params)
			flash[:success] = "Letter edited"
			redirect_to admin_jar_path(@jar)
		else
			render 'edit'
		end
	end

	def unarchive
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = Letter.find(params[:id])
		@letter.is_archived = false
		check_admin_access(@jar)
		@letter.save
		redirect_to jar_letters_path(@jar)
	end

	def archive
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = Letter.find(params[:id])
		@letter.is_archived = true
		check_admin_access(@jar)
		@letter.save
		redirect_to jar_letters_path(@jar)
	end


	def destroy
		@jar = Jar.find_by(site_url: params[:jar_site_url])
		@letter = @jar.letters.find(params[:id])
		check_admin_access(@jar)
		@letter.destroy

		redirect_to jar_letters_path(@jar)
	end

	private
	def letter_params
		params.require(:letter).permit(:from, :title, :text, :colour)
	end
end
