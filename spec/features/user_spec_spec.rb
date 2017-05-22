require 'rails_helper'

RSpec.describe "User", type: :feature do

  def login_with email, password = "secret"
    visit "/users/sign_in"
    within "form#new_user" do
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_button "Log in"
    end
  end

  let!(:user) { create :user, email: "name@example.org", first_name: "Crispy" }

  scenario "registration creates a new user" do
    visit "users/sign_up"
    expect {
      fill_in "user_first_name",  with: "Crispy"
      fill_in "user_last_name",   with: "Winner"
      fill_in "user_email",       with: "user@example.org"
      fill_in "user_password",    with: "secret"
      fill_in "user_password_confirmation", with: "secret"
      click_button "Sign up"
    }.to change(User, :count).by(1)
  end

  describe "session" do
    scenario "doesn't log in the user with invalid email" do
      login_with "invalidemail@example.org"
      expect(page).to_not have_content "Welcome Cripsy"
      expect(page).to_not have_content "Sign out"
    end

    scenario "logs in the user" do
      login_with "name@example.org"
      expect(page).to have_content "Welcome Crispy"
    end

    scenario "log out the user" do
      login_with "name@example.org"
      click_on "Sign out"
      expect(page).to_not have_content "Welcome Crispy"
    end

    scenario "after signed in redirects to current page" do
      # For example
      product = create :product
      visit product_comments_path(product)
      login_with "name@example.org"
      expect(page.current_path).to eq(product_comments_path(product))
    end

    scenario "after sign out redirects to current page" do
      # For example
      product = create :product
      visit product_comments_path(product)
      login_with "name@example.org"
      expect(page.current_path).to eq(product_comments_path(product))
      click_on "Sign out"
      expect(page.current_path).to eq(product_comments_path(product))
    end
  end

  describe "edit" do
    scenario "changes user information with the true current password" do
      login_with "name@example.org"
      click_link "Edit User"
      within "form#edit_user" do
        fill_in "user_first_name", with: "Bucket"
        fill_in "user_last_name", with: "Loser"
        fill_in "user_email", with: "ali@example.org"
        fill_in "user_current_password", with: "secret"
        click_button "Update"
      end
      user.reload
      expect(user.email).to eq("ali@example.org")
      expect(user.first_name).to eq("Bucket")
      expect(user.last_name).to eq("Loser")
    end

    scenario "doesn't change user information with the wrong current password" do
      login_with "name@example.org"
      click_link "Edit User"
      expect {
        within "form#edit_user" do
          fill_in "user_email", with: "ali@example.org"
          fill_in "user_current_password", with: "wrongpassword"
          click_button "Update"
        end
        user.reload
      }.to_not change { user.email }
    end
  end


end