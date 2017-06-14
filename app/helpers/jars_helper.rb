module JarsHelper

    def get_letter_unlock_info(jar)
        if jar.nil? || jar.unlock_time.nil?
            @numberOfLettersAvailable = 0
            @nextUnlockTimeSeconds = 0
            @nextUnlockTimeMinutes = 0
            @nextUnlockTimeHours = 0
        else
            unlock_time = jar.unlock_time
            unlock_rate = jar.refresh_rate * 86400
            timeDifference = ((Time.now - unlock_time))

            if timeDifference < 0
                @numberOfLettersAvailable = 0
                unlockTimeDifferenceValue = -timeDifference
            else 
                @numberOfLettersAvailable = (timeDifference/unlock_rate).ceil
                unlockTimeDifferenceValue = unlock_rate-(timeDifference % unlock_rate)
            end

            @nextUnlockTimeSeconds = (unlockTimeDifferenceValue).floor % 60
            @nextUnlockTimeMinutes = ((unlockTimeDifferenceValue)/60).floor % 60
            @nextUnlockTimeHours = ((unlockTimeDifferenceValue)/3600).floor
        end
    end

end
