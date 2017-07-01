require "rails_helper"

RSpec.describe ApplicationHelper do
  

  it ".full_title" do
    expect(helper.full_title('')).to eq('Crispy Winner')
    expect(helper.full_title("ABC")).to eq('ABC - Crispy Winner')
  end

  # it ".title" do
  # end
end