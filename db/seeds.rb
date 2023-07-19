# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_data = { email: 'admin@example.com', password: 'password', password_confirmation: 'password' }
super_admin_data = { email: 'super_admin@example.com', password: 'password', password_confirmation: 'password' }

User.create!(admin_data) unless User.find_by(email: admin_data[:email])

super_admin = User.find_by(email: super_admin_data[:email]) || User.create!(super_admin_data)

super_admin_role = Role.find_or_create_by!(name: 'super_admin')

super_admin.add_role(:super_admin) unless super_admin.has_role?(:super_admin)
