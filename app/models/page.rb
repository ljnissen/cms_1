class Page < ActiveRecord::Base
	attr_accessor :remember_token
	belongs_to :subject
	has_many :sections
	accepts_nested_attributes_for :subject, :allow_destroy => true 
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end


end
