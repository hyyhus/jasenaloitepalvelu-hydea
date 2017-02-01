class History < ApplicationRecord
	belongs_to :user
	belongs_to :idea
	belongs_to :basket
end
