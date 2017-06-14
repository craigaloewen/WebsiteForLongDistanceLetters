class LetterLink < ApplicationRecord

    validates :letters_number, presence: true

    belongs_to :jar
end
