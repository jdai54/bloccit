# Bloccit
## Bloccit: a Reddit replica to teach the fundamentals of web development and Rails..

Bloccit is a Ruby on Rails application that allows members to create new topics, to write posts or comments, and upvote or downvote posts. Users are able to follow their favorite posts and receive emails when someone comments on a particular post.

This app is deployed on Heroku: https://bloccit-community.herokuapp.com/

The source code is available, here, on github: https://github.com/jdai54/bloccit

## Features
- Users can sign up for an account and view their activity (posts, comments and favorites).
- Users can view, edit and create posts or comment on posts under various topics.
- Users can upvote or downvote a post.
- Users can comment on posts.
- Users can mark posts as favorites to get notified of new comments.
- Admins can alter or delete any topics, posts, or comments.

## Setup and Configuration
**Ruby v. 2.3.3**
**Rails v. 4.2.8**
**Databases:** SQLite (Test, Development), PostgreSQL (Production)

**Gems Used:**
- Factory Girl, Development
- Bootstrap, styling
- Bcrypt, data encryption
- Figaro, environmental variables
- Rspec, TDD

**Set-up:**
- Environmental variables were secured using Figaro and are stored in config/application.yml (ignored by github)
- The config/application.example.yml illustrates the formatting for environmental variables.

**To run Bloccit locally:**
- Clone the repository
- Run bundle install
- Create and migrate the SQLite database with rake db:create and rake db:migrate
- Start the server using rails s
- Run the app on localhost:3000
