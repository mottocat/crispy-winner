require 'rails_helper'

RSpec.describe "Test Capybara", type: :feature do

  specify do
    visit "/products"
  end

end
