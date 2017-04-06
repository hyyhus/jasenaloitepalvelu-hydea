require 'rails_helper'

RSpec.describe "faqs/index", type: :view do
  before(:each) do
    assign(:faqs, [
      Faq.create!(
        :language => "Language",
        :text => "Text"
      ),
      Faq.create!(
        :language => "Language",
        :text => "Text"
      )
    ])
  end

  it "renders a list of faqs" do
    render
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
