class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  # create relation of post class to comment class. The comment class already relates to the post class because of the model generator. The "has_many" method allows the post intance to have many comments related to it and also provides methods that allow us to retrieve comments that belong to a post. Comments are dependent on a post's existence because of the  has_many :comments declaration in Post. When we delete a post, we also need to delete all related comments. We'll perform a "cascade delete", which ensures that when a post is deleted, all of its comments are too
  has_many :comments, dependent: :destroy
  # #4 add the votes association to Post. This relates the models and allows us to call post.votes. We also add dependent: :destroy to ensure that votes are destroyed when their parent post is deleted
  has_many :votes, dependent: :destroy

  after_create :create_vote
# default_scope will order all posts by rank by default. Since we want the largest rank numbers displayed first, we'll use descending (DESC) order
  default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

# Remember that votes in the below code is an implied self.votes
  def up_votes
    # #9 find the up votes for a post by passing value: 1 to where. This fetches a collection of votes with a value of 1. We then call count on the collection to get a total of all up votes
    votes.where(value: 1).count
  end

  def down_votes
    # #10 find the down votes for a post by passing value: -1 to where.  where(value: -1) fetches only the votes with a value of -1. We then call count on the collection to get a total of all up votes
    votes.where(value: -1).count
  end

  def points
    # #11 use ActiveRecord's sum method to add the value of all the given post's votes. Passing :value to sum tells it what attribute to sum in the collection
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  private

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
