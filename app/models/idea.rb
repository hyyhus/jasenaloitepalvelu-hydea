class Idea < ApplicationRecord	
	has_and_belongs_to_many :tags
	has_many :comments
	has_many :likes
	has_many :histories

	#validations
	validates :topic, presence: true, length: {minimum: 2, maximum: 100}, allow_blank: false
	validates :text, :histories, presence: true
	validates :moderate, exclusion: { in: [nil] }
	validates_associated :histories, presence: true

	def basket
		self.histories.last.basket
	end

	ransacker :likes_count_sort do
		Arel.sql('likes_count')
	end


	#Custom sort ABC
	ransacker :topic_case_insensitive, type: :string do
		arel_table[:topic].lower
	end
end
