class UnlockTimeHoldersController < ApplicationController
	def index
		@unlock_time_holder = UnlockTimeHolder.all
	end

	def set_now
		@unlock_time_holder = UnlockTimeHolder.find(params[:id])
		@unlock_time_holder.unlockTime = Time.now 
		@unlock_time_holder.save
		redirect_to unlock_time_holders_path
	end

	def add_letter
		@unlock_time_holder = UnlockTimeHolder.find(params[:id])
		@unlock_time_holder.unlockTime = @unlock_time_holder.unlockTime - 12.hours 
		@unlock_time_holder.save
		redirect_to unlock_time_holders_path
	end

	def remove_letter
		@unlock_time_holder = UnlockTimeHolder.find(params[:id])
		@unlock_time_holder.unlockTime = @unlock_time_holder.unlockTime + 12.hours 
		@unlock_time_holder.save
		redirect_to unlock_time_holders_path
	end



end
