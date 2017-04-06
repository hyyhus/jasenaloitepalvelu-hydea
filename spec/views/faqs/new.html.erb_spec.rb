require 'rails_helper'

RSpec.describe "faqs/new", type: :view do
  before(:each) do
    assign(:faq, Faq.new(
      :language => "MyString",
      :text => "MyString"
    ))
  end

end
