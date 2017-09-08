class JarsController < ApplicationController

    def admin
        @jar = Jar.find_by(site_url: params[:site_url])
        check_admin_access(@jar)
    end

    def add_letter_count
        @jar = Jar.find_by(site_url: params[:site_url])
        add_letter_count_helper(@jar)
        redirect_to admin_jar_path(@jar)
    end

    def remove_letter_count
        @jar = Jar.find_by(site_url: params[:site_url])
        remove_letter_count_helper(@jar)
        redirect_to admin_jar_path(@jar)
    end

    def index
        @jars = Jar.all
    end

    def show
        @jar = Jar.find_by(site_url: params[:site_url])
        @letter = @jar.letters.where(is_archived: false)
        check_jar_access(@jar)
    end

    def show_archived
        @jar = Jar.find_by(site_url: params[:site_url])
        @letter = @jar.letters.where(is_archived: true)
        check_jar_access(@jar)
    end

    def new
        @jar = Jar.new
    end

    def create
        @jar = Jar.new(jar_params)
        @jar.refresh_rate = @jar.refresh_rate * 86400
        @jar.unlock_time = Time.now

        current_jar

		if @jar.save
            flash[:success] = 'Jar created'
            admin_log_in(@jar)
    	    redirect_to admin_jar_path(@jar)
		else
            flash[:warning] = 'Jar not created'
            render 'new'
		end
    end

    def destroy
        @jar = Jar.find_by(site_url: params[:site_url])
        check_admin_access(@jar)
        @jar.destroy
        redirect_to root_path
    end
 
    private
    def jar_params
      params.require(:jar).permit(:site_url, :refresh_rate, :password, :password_confirmation, :is_secured, :jar_password)
    end

    def to_param
		site_url
    end

end