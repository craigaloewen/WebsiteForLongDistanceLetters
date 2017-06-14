class Letter < ApplicationRecord

	validates :from, presence: true, length: { maximum: 50 }
	validates :title, presence: true, length: { maximum: 255 }
    validates :text, presence: true

    belongs_to :jar
end
