# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    email: "login@sitenai.com",
    password: "login-sitenai-user",
    name: "未ログインユーザー",
    id: 0,
)
20.times do |n|
    Post.create!(
        content: "確認用投稿#{n+1}",
        user_name: "未ログインユーザー",
        user_id: 0,
    )
end