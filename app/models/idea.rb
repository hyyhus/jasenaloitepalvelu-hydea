class Idea < ApplicationRecord	
	has_and_belongs_to_many :tags
	has_many :comments
	has_many :likes
	has_many :histories
	has_many :baskets, through: :histories
end
