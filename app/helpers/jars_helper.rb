module JarsHelper

    def get_letter_unlock_info(jar)
        if jar.nil? || jar.unlock_time.nil?
            @numberOfLettersAvailable = 0
            @nextUnlockTimeSeconds = 0
            @nextUnlockTimeMinutes = 0
            @nextUnlockTimeHours = 0
        else
            unlock_time = jar.unlock_time
            unlock_rate = jar.refresh_rate
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

    def add_letter_count_helper(jar)
        if (!jar.nil? && !jar.unlock_time.nil? && !jar.refresh_rate.nil?)
            if !jar.update_attribute(:unlock_time, (jar.unlock_time - jar.refresh_rate) )
                flash[:warning] = 'Letter count not added'
            end
        end
    end

    def remove_letter_count_helper(jar)
        if (!jar.nil? && !jar.unlock_time.nil? && !jar.refresh_rate.nil?)
            if !jar.update_attribute(:unlock_time, (jar.unlock_time + jar.refresh_rate) )
                flash[:warning] = 'Letter count not removed'
            end
        end
    end

end
