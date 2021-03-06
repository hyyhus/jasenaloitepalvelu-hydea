class User < ApplicationRecord
	has_many :histories
	has_many :comments
	has_many :likes

	#Validations
	validates :name, presence: true
	validates :persistent_id, uniqueness: true, presence: true
	validates :banned, exclusion: { in: [nil] }

end
