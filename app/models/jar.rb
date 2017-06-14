class Jar < ApplicationRecord

  validates :siteurl, presence: true, length: { maximum: 50 }

  belongs_to :user
  has_many :letters
  has_many :letter_links
end
