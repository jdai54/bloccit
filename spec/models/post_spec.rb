require 'rails_helper'

RSpec.describe Post, type: :model do
  # #1 using the "let" method, create a new instance of the Post class and name it "post". "let" dynamically defines a method (in this case, post), and upon first call within a spec(the "it" block), computes and stores the returned value
  #let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  # #3 create a parent topic for post
  let(:topic) { Topic.create!(name: name, description: description) }
  # #1 create a user to associate with a test post
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  # #4 associate "post" with "topic" via topic.posts.create!. This is a chained method call which creates a post for a given topic. Also associate user with post
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  # #2 test whether "post" has attributes named "title" and "body". This tests whether "post' will return a non-nil value when "post.title" and "post.body" are called
  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end
end
