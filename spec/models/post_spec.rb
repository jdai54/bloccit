require 'rails_helper'

RSpec.describe Post, type: :model do
  # #1 using the "let" method, create a new instance of the Post class and name it "post". "let" dynamically defines a method (in this case, post), and upon first call within a spec(the "it" block), computes and stores the returned value
  #let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }
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
      expect(post).to have_attributes(title: post.title, body: post.body)
    end
  end

  describe "voting" do
    # #5 create three up votes and two down votes before each voting spec
    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end
    # #6 test that up_votes returns the count of up votes
    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect( post.up_votes ).to eq(@up_votes)
      end
    end

    # #7 test that down_votes returns the count of down votes
    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect( post.down_votes ).to eq(@down_votes)
      end
    end

    # #8 test that points returns the sum of all votes on the post
    describe "#points" do
      it "returns the sum of all down and up votes" do
        expect( post.points ).to eq(@up_votes - @down_votes)
      end
    end

    describe "#update_rank" do
  # #28 expect that a post's rank will be determined by the following calculation: Determine the age of the post by subtracting a standard time from its  created_at time. A standard time in this context is known as an epoch. This makes newer posts start with a higher ranking, which decays over time. Divide the distance in seconds since the epoch by the number of seconds in a day. This gives us the age in days; Add the points (i.e. sum of the votes) to the age. This means that the passing of one day will be equivalent to one down vote
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end

      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1)
        expect(post.rank).to eq (old_rank + 1)
      end

      it "updates the rank when a down vote is created" do
        old_rank = post.rank
        post.votes.create!(value: -1)
        expect(post.rank).to eq (old_rank - 1)
      end
    end
  end
end
