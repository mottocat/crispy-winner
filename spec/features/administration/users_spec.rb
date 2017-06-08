require "rails_helper"

module Administration
  RSpec.describe "Users", type: :feature do
    
    let!(:admin) { 
      create :admin,
              first_name: "Davut",
              last_name: "Cinoglu",
              email: "cinogludavut@example.org",
              sign_in_count: 13,
              created_at: 4.months.ago
     }

    before do
      login admin

      create :user,
              first_name: "Can",
              last_name: "Yilmaz",
              email: "canyilmaz@example.org",
              sign_in_count: 5,
              current_sign_in_at: 1.hour.ago,
              last_sign_in_at: 2.days.ago,
              created_at: 4.days.ago

      create :user,
              first_name: "Zeynep",
              last_name: "Kaya",
              email: "zeynep@example.org",
              sign_in_count: 0,
              current_sign_in_at: 3.hours.ago,
              last_sign_in_at: 4.days.ago,
              created_at: 6.days.ago


      visit administration_path
      click_link "USERS (3)"
    end

    it "get users" do
      expect(page).to have_content("USERS (3)")
      expect(page).to have_css("tbody tr", count: 3)
    end

    it "sorts default by created_at" do
      check_table_row_sorting %w(Davut Zeynep Can)
      click_link "Created At"
      check_table_row_sorting %w(Can Zeynep Davut)
    end

    it "sorts by first_name" do
      click_link "First Name"
      check_table_row_sorting %w(Can Davut Zeynep)

      click_link "First Name"
      check_table_row_sorting %w(Zeynep Davut Can)
    end

    it "sorts by last name" do
      click_link "Last Name"
      check_table_row_sorting %w(Cinoglu Kaya Yilmaz)

      click_link "Last Name"
      check_table_row_sorting %w(Yilmaz Kaya Cinoglu)
    end

    it "sorts by email" do
      click_link "Email"
      check_table_row_sorting %w(canyilmaz@example.org cinogludavut@example.org zeynep@example.org)

      click_link "Email"
      check_table_row_sorting %w(zeynep@example.org cinogludavut@example.org canyilmaz@example.org)
    end

    it "sorts by sign_in_count" do
      click_link "Sign In Count"
      check_table_row_sorting %w(Zeynep Can Davut)

      click_link "Sign In Count"
      check_table_row_sorting %w(Davut Can Zeynep)
    end

    it "sorts by current_sign_in_at" do
      click_link "Current Sign In At"
      check_table_row_sorting %w(Zeynep Can Davut)

      click_link "Current Sign In At"
      check_table_row_sorting %w(Davut Can Zeynep)
    end

    it "sorts by last_sign_in_at" do
      click_link "Last Sign In At"
      check_table_row_sorting %w(Zeynep Can Davut)

      click_link "Last Sign In At"
      check_table_row_sorting %w(Davut Can Zeynep)
    end

    it "sorts by admin" do
      within "th:last-child" do
        click_link "Admin"
      end
      
      within "th:last-child" do
        click_link "Admin (asc)"
      end

      check_table_row_sorting %w(Davut)
    end

  end
end