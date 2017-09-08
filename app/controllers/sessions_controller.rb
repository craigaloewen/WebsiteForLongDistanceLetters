class SessionsController < ApplicationController
    def new
      @jar = Jar.find_by(site_url: params[:jar_site_url])  
      if logged_in?
        redirect_to jar_path(@jar)
      end
    end
  
    def create
      jar = Jar.find_by(site_url: params[:jar_site_url])      
      if jar && jar.authenticate(params[:session][:password])
        log_in jar
        redirect_to jar_path(jar)
      else
        flash.now[:danger] = 'Invalid password'
        render 'new'
      end
    end
  
    def destroy
      log_out
      redirect_jar = Jar.find_by(site_url: params[:jar_site_url])   
      redirect_to jar_path(redirect_jar)
    end

    def admin_new
      @jar = Jar.find_by(site_url: params[:jar_site_url])  
    end
  
    def admin_create
      jar = Jar.find_by(site_url: params[:jar_site_url])      
      if jar && jar.authenticate(params[:session][:password])
        admin_log_in jar
        redirect_to admin_jar_path(jar)
      else
        flash.now[:danger] = 'Invalid password'
        render 'admin_new'
      end
    end
  
    def admin_destroy
      admin_log_out
      redirect_jar = Jar.find_by(site_url: params[:jar_site_url])   
      redirect_to jar_path(redirect_jar)
    end


  end
  