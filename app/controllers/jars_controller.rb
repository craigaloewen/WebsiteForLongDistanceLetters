class JarsController < ApplicationController

    def admin
        @jar = Jar.find_by(site_url: params[:site_url])
    end

    def show
        @jar = Jar.find_by(site_url: params[:site_url])
        @letter = @jar.letters.all
    end

    def new
        @jar = Jar.new
    end

    def create
        @jar = Jar.new(jar_params)
        @jar.unlock_time = Time.now

		if @jar.save
			flash[:success] = 'Jar created'
    	    redirect_to admin_jar_path(@jar)
		else
            flash[:warning] = 'Jar not created'
            render 'new'
		end
    end

    def destroy
        @jar = Jar.find_by(site_url: params[:site_url])
        @jar.destroy
        redirect_to root_path
    end
 
    private
    def jar_params
      params.require(:jar).permit(:site_url, :refresh_rate)
    end

    def to_param
		site_url
    end

end