class Comment < ApplicationRecord
	belongs_to :idea
	belongs_to :user

	validates :text,:time,:idea,:user, presence: true
	validates_associated :idea, :user
end
