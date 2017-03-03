class History < ApplicationRecord
	belongs_to :user
	belongs_to :idea

	#Validations
	validates :time, :basket, :user_id, presence: true
	# validate idea id with nil as well???
end
