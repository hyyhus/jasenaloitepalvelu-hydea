class SessionsController < ApplicationController
	def new
	end


	def create
		user = User.find_by persistent_id: params[:persistent_id]
		# talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa)
		session[:user_id] = user.id if not user.nil?
		# uudelleen ohjataan käyttäjä omalle sivulleen
		redirect_to user
    end


	def destroy
		# nollataan sessio
		session[:user_id] = nil
		# uudelleenohjataan sovellus pääsivulle
		redirect_to :root
	end
end
