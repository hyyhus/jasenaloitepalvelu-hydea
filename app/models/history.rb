class History < ActiveRecord::Base
	belongs_to :user
	belongs_to :idea
	belongs_to :basket
end
