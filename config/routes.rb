Rails.application.routes.draw do
  resources :topics do
    # #34 pass "resources :posts" to the "resources :topics" block. This nests the post routes under the topic routes
    resources :posts, except: [:index]
  end

  # #4 we use only: [] because we don't want to create any /posts/:id routes, just posts/:post_id/comments routes
  resources :posts, only: [] do
  # #5 only add create and destroy routes for comments. We'll display comments on the posts show view, so we won't need index or new routes. We also won't give users the ability to view individual comments or edit comments, removing the need for show, update, and edit routes
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  # These new lines create POST routes at the URL posts/:id/up-vote and  posts/:id/down-vote. The as key-value pairs at the end stipulate the method names which will be associated with these routes: up_vote_path and  down_vote_path
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  # #7
  resources :users, only: [:new, :create]

  post 'users/confirm' => 'users#confirm'

  resources :sessions, only: [:new, :create, :destroy]


  # #2 we remove "get "welcome/index" because we've declared the index view as the root view. We also modify the "about" route to allow users to visit "/about" rather than "/welcome/about"
  get 'about' => 'welcome#about'
  # 'root' declares the default page the app loads when we navigate to the home page URL. "root" is a method that takes a hash as an argument. here we use implied hash syntax instead of: root{{to: 'welcome#index'}}
  root 'welcome#index'
end
