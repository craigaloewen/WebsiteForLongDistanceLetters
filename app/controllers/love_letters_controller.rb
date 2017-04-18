class LoveLettersController < ApplicationController
	def new
	end

	def create
		render plain: params[:love_letter].inspect
	end
end
