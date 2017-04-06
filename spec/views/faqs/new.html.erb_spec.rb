require 'rails_helper'

RSpec.describe "faqs/new", type: :view do
  before(:each) do
    assign(:faq, Faq.new(
      :language => "MyString",
      :text => "MyString"
    ))
  end

  it "renders new faq form" do
    render

    assert_select "form[action=?][method=?]", faqs_path, "post" do

      assert_select "input#faq_language[name=?]", "faq[language]"

      assert_select "input#faq_text[name=?]", "faq[text]"
    end
  end
end
