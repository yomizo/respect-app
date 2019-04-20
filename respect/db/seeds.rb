# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding:utf-8

users = (1..50).map do
  User.create!(
    name: Faker::Name.name,
    password: Faker::Crypto.md5,
    email: Faker::Internet.email,
    image_name: Faker::File.file_name('path/to')
  )
end

posts = (1..100).map do
  Post.create!(
    respect: rand(0..1),
    lat: rand(-35..-11),
    lng: rand(111..152),
    user_id: rand(1..50),
    comment: Faker::Lorem.paragraph(2)
  )
end

metoos = (1..100).map do
  Metoo.create!(
    user_id: rand(1..50),
    post_id: rand(1..100)
  )
end

