class WelcomeController < ApplicationController

	def index
		unlockTimeHolder = UnlockTimeHolder.first

		if unlockTimeHolder.nil?
			unlockTimeHolder = UnlockTimeHolder.new(unlockTime: Time.now)
			unlockTimeHolder.save
		end

		unlockTime = unlockTimeHolder.unlockTime
		timeDifference = ((Time.now - unlockTime))

		if timeDifference < 0
			@numberOfLettersAvailable = 0
			unlockTimeDifferenceValue = -timeDifference
		else 
			@numberOfLettersAvailable = (timeDifference/172800).ceil
			unlockTimeDifferenceValue = 172800-(timeDifference % 172800)
		end

		@nextUnlockTimeSeconds = (unlockTimeDifferenceValue).floor % 60
		@nextUnlockTimeMinutes = ((unlockTimeDifferenceValue)/60).floor % 60
		@nextUnlockTimeHours = ((unlockTimeDifferenceValue)/3600).floor

		@canView

		if Time.now > unlockTime 
			@canView = true
		else 
			@canView = false
		end



		@letter = Letter.where(isArchived: false)
	end

	def testhomepage

	end

	def show_archived
		@letter = Letter.where(isArchived: true).order("updated_at").reverse
	end

end
