source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

# #1
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# #2
group :development do
  gem 'sqlite3'
end

# #3 add rspec-rails gem to the :development and :test groups because we want its tasks and generators to be available in both environments
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda'
# FactoryGirl is a canonical Ruby gem which allows us to build objects we can use for testing. Factories allow us to modify the behavior of a given object type in a single place
  gem 'factory_girl_rails', '~> 4.0'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'bootstrap-sass'

# Used for encrypting User passwords
gem 'bcrypt'

gem 'figaro', '1.0'
