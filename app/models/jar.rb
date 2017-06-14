class Jar < ApplicationRecord

  validates :site_url, presence: true, length: { maximum: 50 }
  validates :refresh_rate, presence: true

  belongs_to :user
  has_many :letters
  has_many :letter_links
end
