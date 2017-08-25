module LettersHelper


    def current_letter_link
        if !@letter_link.nil?
            @current_letter_link = @letter_link
        end
    end

    def valid_letter_link?
        ( !current_letter_link.nil? && !current_letter_link.token.nil?  )
    end


end
