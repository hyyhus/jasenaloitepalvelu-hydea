class History < ApplicationRecord
	belongs_to :user
	belongs_to :idea

	#Validations
	validates :basket, inclusion: { in: ["New", "Approved", "Changing", "Changed", "Not Changed", "Rejected"]}
	validates :time, :basket, :user, presence: true
	validates_associated :user

end
