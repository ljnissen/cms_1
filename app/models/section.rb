class Section < ActiveRecord::Base
	attr_accessor :remember_token
	belongs_to :page

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
end
