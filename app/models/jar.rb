class Jar < ApplicationRecord

  validates :site_url, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :refresh_rate, presence: true

  has_many :letters
  has_many :letter_links

  has_secure_password
  validates :password, presence: true, length: { minimum: 3 }
  
  attr_encrypted_options.merge!(:encode => true)
  attr_encrypted :jar_password, :key => Rails.application.secrets.secret_key_base

	# Returns the hash digest of the given string.
	def Jar.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def to_param
		site_url
	end

end
