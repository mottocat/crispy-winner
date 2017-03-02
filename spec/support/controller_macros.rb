module ControllerMacros
  def login user = create(:user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    user
  end
end