require 'rails_helper'

module Haka
	RSpec.describe AuthController, :type => :controller do

		describe "GET #new" do
			it "gets Haka login page" do
				get :new
				expect(response).to be_redirect
				haka_login_address = Regexp.new(Regexp.escape(Hydea::Haka::SAML_IDP_SSO_TARGET_URL))
				Hydea::Haka::HAKA_TESTSERVER_METADATA_URL = "https://haka.funet.fi/metadata/haka-metadata.xml"


				expect(response).to redirect_to(haka_login_address)
		    end

		    it "doesn't Haka login page" #do
				
		    #end
		end
		
	end
end