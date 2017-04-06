require 'rails_helper'

RSpec.describe "faqs/edit", type: :view do
  before(:each) do
    @faq = assign(:faq, Faq.create!(
      :language => "MyString",
      :text => "MyString"
    ))
  end

end
