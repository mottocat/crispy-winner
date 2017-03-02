module TestHelpers
  def login user = create(:user)
    visit "users/sign_in"
    within "form#new_user" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
    end
    
    user
  end
end