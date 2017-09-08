class LetterLink < ApplicationRecord

    validates :letters_number, presence: true

    belongs_to :jar

    def to_param
		  token
	  end

end
