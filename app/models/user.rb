class User < ApplicationRecord
	has_many :histories
	has_many :comments
	has_many :likes

	validates :persistent_id, uniqueness: true
	

end
