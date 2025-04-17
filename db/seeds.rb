# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile = "はじめまして、Oliviaです！"
  user.image.attach(
    io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"),
    filename: "no_image.jpg"
  )
end


liam = User.find_or_create_by!(email: "liam@example.com") do |user|
  user.name = "Liam"
  user.password = "password"
  user.profile = "Liamです。よろしくお願いします！"
  user.image.attach(
    io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"),
    filename: "no_image.jpg"
  )
end


olivia.posts.find_or_create_by!(title: "マンゴーの魅力") do |post|
  post.body = "宮崎のマンゴー、本当に最高！"
  post.image.attach(
    io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"),
    filename: "no_image.jpg"
  )
end


liam.posts.find_or_create_by!(title: "規格外マンゴーって？") do |post|
  post.body = "少し形が悪くても味は抜群。安くておいしい！"
  post.image.attach(
    io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"),
    filename: "no_image.jpg"
  )
end

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end