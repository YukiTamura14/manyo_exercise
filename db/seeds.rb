# frozen_string_literal: true

User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.name = 'admin'
  user.admin = true
  user.password = 'password'
  user.password_confirmation = 'password'
end

User.find_or_create_by!(email: 'general@example.com') do |user|
  user.name = 'general'
  user.admin = false
  user.password = 'general'
  user.password_confirmation = 'general'
end
