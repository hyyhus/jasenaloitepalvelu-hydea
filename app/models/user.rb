class User < ActiveRecord::Base
	has_many :histories
	has_many :comments
	has_many :likes
end
