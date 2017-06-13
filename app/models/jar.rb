class Jar < ApplicationRecord
  belongs_to :user
  has_many :letters
  has_many :letter_links
end
