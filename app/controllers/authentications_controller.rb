class AuthenticationsController < ApplicationController
	def create
		auth = env['omniauth.auth']

		authentication = Authentication.find_by_provider_and_uid(
			auth['provider'], 
			auth[:uid])

		if(authentication)
			sign_in authentication.user
			flash[:notice] = "Authentication successful"
			redirect_to root_url
		elsif current_user
			current_user.authentications.create(
				:provider => auth['provider'], 
				:uid => auth[:uid])	
			flash[:notice] = "Authentication successful"
			redirect_to root_url
		else
			redirect_to signup_url
		end
	end

	def destroy
		authentication = current_user.authentications.find(params[:id])
		authentication.destroy
		redirect_to root_url
	end
end
