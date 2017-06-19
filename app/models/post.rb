class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  # create relation of post class to comment class. The comment class already relates to the post class because of the model generator. The "has_many" method allows the post intance to have many comments related to it and also provides methods that allow us to retrieve comments that belong to a post. Comments are dependent on a post's existence because of the  has_many :comments declaration in Post. When we delete a post, we also need to delete all related comments. We'll perform a "cascade delete", which ensures that when a post is deleted, all of its comments are too
  has_many :comments, dependent: :destroy
# default_scope will order all posts by their created_at date, in descending order, with the most recent posts displayed first. The most recent posts will be displayed first on topic show views (where the posts associated with a topic are listed)
  default_scope { order('created_at DESC') }
  scope: ordered_by_title => { order('title DESC')}
  scope: ordered_by_reverse_created_at => { order('created_at ASC')}

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
