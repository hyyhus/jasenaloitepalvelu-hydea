class Idea < ApplicationRecord
	belongs_to :basket
	has_and_belongs_to_many :tags
	has_many :comments
	has_many :likes
	has_many :histories
	validates :topic,	presence: true,
						length: { maximum: 55 }
	validates :text, 	presence: true,
						length: { maximum: 255 }

end
