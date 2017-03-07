class Idea < ApplicationRecord	
	has_and_belongs_to_many :tags
	has_many :comments
	has_many :likes
	has_many :histories

	#validations
	validates :topic, presence: true, length: {minimum: 2, maximum: 100}, allow_blank: false
	validates :text, :histories, presence: true
	validates_associated :histories, presence: true
end
