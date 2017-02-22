module Hydea 

  module Haka
    SAML_NAME_IDENTIFIER_FORMAT         = ENV.fetch('SAML_NAME_IDENTIFIER_FORMAT')
    SAML_IDP_SSO_TARGET_URL             = ENV.fetch("SAML_IDP_SSO_TARGET_URL")
    SAML_IDP_ENTITY_ID                  = ENV.fetch("SAML_IDP_ENTITY_ID")
    SAML_IDP_CERT_FINGERPRINT           = ENV.fetch("SAML_IDP_CERT_FINGERPRINT")
    SAML_IDP_CERT                       = ENV.fetch("SAML_IDP_CERT")

    SAML_ASSERTION_CONSUMER_SERVICE_URL = ENV.fetch("SAML_ASSERTION_CONSUMER_SERVICE_URL")

     SAML_MY_ENTITY_ID                   = ENV.fetch("SAML_MY_ENTITY_ID")
     SAML_MY_CERT                        = ENV.fetch("SAML_MY_CERT")
     SAML_MY_PRIVATE_KEY                 = ENV.fetch("SAML_MY_PRIVATE_KEY")


     #HAKA_PERSONALUNIQUECODE             = ENV.fetch("HAKA_PERSONALUNIQUECODE")
     #HAKA_MAIL                           = ENV.fetch("HAKA_MAIL")
     #HAKA_DISPLAYNAME                    = ENV.fetch("HAKA_DISPLAYNAME")
     #HAKA_HOMEORGANIZATION               = ENV.fetch("HAKA_HOMEORGANIZATION")

     HAKA_METADATA_URL			 = ENV.fetch("HAKA_METADATA_URL")
     #HAKA_STUDENT_NUMBER_FIELD           = ENV.fetch("HAKA_STUDENT_NUMBER_FIELD")
  end  

end
