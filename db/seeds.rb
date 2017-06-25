# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create Users
5.times do
  User.create!(
  name: RandomData.random_name,
  email: RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

# Create Topics
15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

# Create posts
50.times do
  # #1 use "create!" with a bang which instructs the method to raise an error if there's a problem with the data being seeded. Using "create" without a bang coudl fail without warning causing the error to surface later
  Post.create!(
  # #2 the RandomData method will create random strings for "title" and "body"
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData. random_paragraph
  )
end
posts = Post.all

# Create comments
# #3 call "times' a specified number of times based on the Integer. "
100.times do
  Comment.create!(
  # #4 call "sample" on the array returned by "Post.all" in order to pick a random post to associate with each comment. "sample" returns a random element from the array every time it's called
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a moderator user
moderator = User.create!(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'helloworld',
  role:     'moderator'
)


 # Create a member
member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
