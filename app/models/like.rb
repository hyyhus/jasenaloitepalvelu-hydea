class Like < ApplicationRecord
	belongs_to :idea
	belongs_to :user

        validates :like_type, inclusion: { in: %w(like)}
	validates :idea, presence: true
	validates :user, presence: true
end
