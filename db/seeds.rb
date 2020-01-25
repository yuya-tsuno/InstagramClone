# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'i18n'
require 'faker'

I18n.locale = :ja
Faker::Config.locale = :ja

50.times do |n|
  name = Faker::Games::Pokemon.name
  email = "#{SecureRandom.hex(8)}@gmail.com"
  password = "password"
  
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end