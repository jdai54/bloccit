class Post < ActiveRecord::Base
  belongs_to :topic
  # create relation of post class to comment class. The comment class already relates to the post class because of the model generator. The "has_many" method allows the post intance to have many comments related to it and also provides methods that allow us to retrieve comments that belong to a post. Comments are dependent on a post's existence because of the  has_many :comments declaration in Post. When we delete a post, we also need to delete all related comments. We'll perform a "cascade delete", which ensures that when a post is deleted, all of its comments are too
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
end
