class LetterLink < ApplicationRecord

    validates :numLetters, presence: true

    belongs_to :jar
end
