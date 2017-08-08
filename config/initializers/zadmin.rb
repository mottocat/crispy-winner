# Admin = User.find_or_create_by(admin: true) do |admin|
#   admin.first_name = "Admin"
#   admin.last_name = "Admin"
#   admin.email = ENV['APP_ADMIN_EMAIL']
#   admin.password = ENV['APP_ADMIN_PASSWORD']
#   admin.password_confirmation = ENV['APP_ADMIN_PASSWORD']
# end