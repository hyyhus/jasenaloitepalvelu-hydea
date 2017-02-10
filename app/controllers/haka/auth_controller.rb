module Haka

  class AuthController < ApplicationController


    #SAML Initialization
  	def new
  		
  		request = OneLogin::RubySaml::Authrequest.new
  		redirect_to(request.create(saml_settings))
  	end  
    
    def consume
    	response = OneLogin::RubySaml::Response.new(params[:SAMLResponse],
    		settings: saml_settings,
    		allowed_clock_drift: 5.seconds)

    	unless response.is_valid?
    		Rails.logger.error "Invalid SAML response: #{response.errors}"
    		Rollbar.error "Invalid SAML response", errors: response.errors

    		redirect_to frontend_error_path("invalid_saml_response")
    		return
    end


    private
    begin


      def saml_settings
      	byebug
    	settings = OneLogin::RubySaml::Settings.new

    	settings.assertion_consumer_service_url = "http://#{request.host}/auth/consume"



      end
      
      settings
    end

    end
 end
end
