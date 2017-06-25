# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  #ダミーのuser情報を100件作成する
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               )
end

#ブログテーブルのテストレコードを100件生成する
n = 1
while n <= 100
  Blog.create(
    title: "あああ",
    content: "hoge",
    user_id: n,
    name: (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
  )
  n = n + 1
end
