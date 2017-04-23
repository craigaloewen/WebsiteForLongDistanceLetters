class UnlockTimeHoldersController < ApplicationController
	def index
		@unlock_time_holder = UnlockTimeHolder.all
	end
end
