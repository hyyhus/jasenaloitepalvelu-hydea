class Like < ActiveRecord::Base
	belongs_to :idea
	belongs_to :user
end
