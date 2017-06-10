# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create posts
50.times do
  # #1 use "create!" with a bang which instructs the method to raise an error if there's a problem with the data being seeded. Using "create" without a bang coudl fail without warning causing the error to surface later
  Post.create!(
  # #2 the RandomData method will create random strings for "title" and "body"
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

# Create comments
# #3 call "times' a specified number of times based on the Integer. "
100.times do
  Comment.create!(
  # #4 call "sample" on the array returned by "Post.all" in order to pick a random post to associate with each comment. "sample" returns a random element from the array every time it's called
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

10.times do
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

puts "Seed Finished"
puts "#{Question.count} questions created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
