class SessionsController < ApplicationController
	def new
	end
	
	def destroy
		# nollataan sessio
		session[:user_id] = nil
		# uudelleenohjataan sovellus pääsivulle
		redirect_to :root
	end
end
