require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :name => "Name",
        :brand => "Brand"
      ),
      Product.create!(
        :name => "Name",
        :brand => "Brand"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Name", :count => 2
    assert_select "tr>td", :text => "Brand", :count => 2
  end
end
