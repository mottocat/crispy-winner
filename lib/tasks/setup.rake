require "highline"

namespace :setup do
  desc "Creates an admin user"
  task admin: :environment do
    if user = User.find_by(admin: true)
      puts "An admin user has been installed by: " + user.email
    else
      puts "Registering an admin user"

      ui = HighLine.new

      user = User.new.tap do |user|
        user.first_name = ui.ask "Admin first name"
        user.last_name = ui.ask "Admin last name"
        user.email = ui.ask "Admin email"
        user.password = ui.ask("Admin password") { |q| q.echo = false }
        user.password_confirmation = ui.ask("Admin password_confirmation") { |q| q.echo = false }
        user.admin = true
        user.save
      end

      puts "Admin user was created. Now you can sign in via " + user.email
    end
  end
end