class Faq < ApplicationRecord
    validates :text,:language, presence: true
end