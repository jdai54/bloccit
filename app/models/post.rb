class Post < ActiveRecord::Base
  # create relation of post class to comment class. The comment class already relates to the post class because of the model generator. The "has_many" method allows the post intance to have many comments related to it and also provides methods that allow us to retrieve comments that belong to a post
  has_many :comments
end
