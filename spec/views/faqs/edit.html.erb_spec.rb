require 'rails_helper'

RSpec.describe "faqs/edit", type: :view do
  before(:each) do
    @faq = assign(:faq, Faq.create!(
      :language => "MyString",
      :text => "MyString"
    ))
  end

  it "renders the edit faq form" do
    render

    assert_select "form[action=?][method=?]", faq_path(@faq), "post" do

      assert_select "input#faq_language[name=?]", "faq[language]"

      assert_select "input#faq_text[name=?]", "faq[text]"
    end
  end
end
