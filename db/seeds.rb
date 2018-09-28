# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

david = User.create! email: 'david@lumastic.com',
                     password: 'password',
                     role: Roleable::ROLE_ADMIN

drew = User.create! email: 'drew@lumastic.com',
                     password: 'password',
                     role: Roleable::ROLE_ADMIN

Course.create!