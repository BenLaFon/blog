# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

Comment.destroy_all
Post.destroy_all
User.destroy_all

User.create(email: "test@email.com", password: "666666", username: "testusername")


4.times do
  user = User.new(email: Faker::Internet.free_email, password: Devise.friendly_token, username: Faker::GreekPhilosophers.name)
  user.save
  puts "user #{user.id} created"
  rand(1..5).times do
    post = Post.new(title: Faker::GreekPhilosophers.quote, content: Faker::Lorem.paragraphs )
    post.user = user
    rand(2..6).times do
      comment = Comment.new(content: Faker::ChuckNorris.fact, post: post, user: user)
      comment.save
      puts "comment #{comment.id} created"
    end
    post.save
  end

end
