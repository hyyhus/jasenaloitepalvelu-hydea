class Tag < ApplicationRecord
	has_and_belongs_to_many :ideas

	validates :text, uniqueness: true, presence: true
end
