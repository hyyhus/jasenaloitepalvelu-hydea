module Hydea

  # module Public
  #   SITE_ADDRESS        = ENV.fetch('SITE_ADDRESS')
  #   EMAIL_FROM_ADDRESS  = ENV.fetch('EMAIL_FROM_ADDRESS')
  #   EMAIL_FROM_NAME     = ENV.fetch('EMAIL_FROM_NAME')
  #   EXTERNAL_INFO_SITE  = ENV.fetch('EXTERNAL_INFO_SITE')
  #   EXTERNAL_INFO_PHONE = ENV.fetch('EXTERNAL_INFO_PHONE')
  # end

  # module Config
  #   BLANK_CANDIDATE_NUMBER       = 1
  #   IS_EDARI_ELECTION            = !!(ENV.fetch('IS_EDARI_ELECTION') =~ /true/)
  #   IS_HALLOPED_ELECTION         = !IS_EDARI_ELECTION
  #   ELECTION_TERMINATES_AT       = Time.parse ENV.fetch('ELECTION_TERMINATES_AT')
  #   VOTE_SIGNIN_STARTS_AT        = Time.parse ENV.fetch('VOTE_SIGNIN_STARTS_AT')
  #   VOTE_SIGNIN_ENDS_AT          = Time.parse ENV.fetch('VOTE_SIGNIN_ENDS_AT')
  #   VOTE_SIGNIN_DAILY_CLOSING_TIME = ENV.fetch('VOTE_SIGNIN_DAILY_CLOSING_TIME')
  #   VOTE_SIGNIN_DAILY_OPENING_TIME = ENV.fetch('VOTE_SIGNIN_DAILY_OPENING_TIME')
  #   ELIGIBILITY_SIGNIN_STARTS_AT = Time.parse ENV.fetch('ELIGIBILITY_SIGNIN_STARTS_AT')
  #   ELIGIBILITY_SIGNIN_ENDS_AT   = Time.parse ENV.fetch('ELIGIBILITY_SIGNIN_ENDS_AT')
  #   VOTING_GRACE_PERIOD_MINUTES  = ENV.fetch('VOTING_GRACE_PERIOD_MINUTES').to_i.minutes

  #   VOTER_SESSION_JWT_EXPIRY_MINUTES = ENV.fetch('VOTER_SESSION_JWT_EXPIRY_MINUTES').to_i.minutes
  #   EMAIL_LINK_JWT_EXPIRY_MINUTES    = ENV.fetch('EMAIL_LINK_JWT_EXPIRY_MINUTES').to_i.minutes
  #   SIGN_IN_JWT_EXPIRY_SECONDS       = ENV.fetch('SIGN_IN_JWT_EXPIRY_SECONDS').to_i.seconds

  # end

  # module SanityCheck
  #   # These two JWT secrets must differ in order to differentiate access between
  #   # Voter API and ServiceUser API.
  #   if Rails.application.secrets.jwt_voter_secret == Rails.application.secrets.jwt_service_user_secret
  #     raise "JWT_VOTER_SECRET must differ from JWT_SERVICE_USER_SECRET"
  #   end
  # end

  module Haka
    # SAML_NAME_IDENTIFIER_FORMAT         = ENV.fetch('SAML_NAME_IDENTIFIER_FORMAT')
    SAML_IDP_SSO_TARGET_URL             = ENV.fetch("SAML_IDP_SSO_TARGET_URL")
    SAML_IDP_ENTITY_ID                  = ENV.fetch("SAML_IDP_ENTITY_ID")
    SAML_IDP_CERT_FINGERPRINT           = ENV.fetch("SAML_IDP_CERT_FINGERPRINT")
    #SAML_IDP_CERT                       = ENV.fetch("SAML_IDP_CERT")

    SAML_ASSERTION_CONSUMER_SERVICE_URL = ENV.fetch("SAML_ASSERTION_CONSUMER_SERVICE_URL")

     SAML_MY_ENTITY_ID                   = ENV.fetch("SAML_MY_ENTITY_ID")
    # SAML_MY_CERT                        = ENV.fetch("SAML_MY_CERT")
    # SAML_MY_PRIVATE_KEY                 = ENV.fetch("SAML_MY_PRIVATE_KEY")

     HAKA_STUDENT_NUMBER_FIELD           = ENV.fetch("HAKA_STUDENT_NUMBER_FIELD")
  end

  # module Frontend
  #   API_BASE_URL         = ENV.fetch("FRONTEND_API_BASE_URL")
  #   ROLLBAR_ACCESS_TOKEN = ENV.fetch("FRONTEND_ROLLBAR_ACCESS_TOKEN")
  #   ROLLBAR_ENVIRONMENT  = ENV.fetch("FRONTEND_ROLLBAR_ENVIRONMENT")
  #   GOOGLE_ANALYTICS_ID  = ENV.fetch("FRONTEND_GOOGLE_ANALYTICS_ID")
  # end

end