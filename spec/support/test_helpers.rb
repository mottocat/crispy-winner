module TestHelpers
  def login user = create(:user)
    visit new_user_session_path
    within "form#new_user" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
    end
    
    user
  end

  def logout
    click_on "Sign out"
  end

  def handle_js_confirm(accept=true)
    page.evaluate_script "window.original_confirm_function = window.confirm"
    page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
    yield
  ensure
    page.evaluate_script "window.confirm = window.original_confirm_function"
  end
  
  def images_dir
    "#{Rails.root}/spec/support/images"
  end
end