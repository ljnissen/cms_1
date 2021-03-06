class Subject < ActiveRecord::Base
	attr_accessor :remember_token

	has_many :pages, :dependent => :destroy
	accepts_nested_attributes_for :pages, :allow_destroy => true
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
end
