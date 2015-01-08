# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all
Product.create!(name: 'Toothbrush', summary: 'The toothbrush is an oral hygiene instrument used to clean the teeth and gums that consists of a head of tightly clustered bristles mounted on a handle, which facilitates the cleansing of hard-to-reach areas of the mouth.', image_url: 'toothbrush.jpg', price: 49.95)

User.delete_all
User.create!(username: 'test', password_digest: BCrypt::Password.create('secret'))