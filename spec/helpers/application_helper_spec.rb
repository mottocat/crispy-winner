require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  

  it ".humanize_status_for" do
    expect(helper.humanize_status_for :using).to eq("I am using this product now")
    expect(helper.humanize_status_for :used).to eq("I used this product before")
  end

end