class History < ActiveRecord::Base
	has_one :user
	belongs_to :idea
end
