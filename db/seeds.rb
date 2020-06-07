# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# admin = Admin.new
# admin.email = "admin@mail.com"
# admin.password = '123456'
# admin.password_confirmation = '123456'
# admin.save!

user = User.new
user.email = "user@mail.com"
user.password = '123456'
user.password_confirmation = '123456'
user.first_name = "Dimka"
user.last_name = "Sergeichuk"
user.login = "dimkas"
user.address = "Zelenograd"
user.save!
