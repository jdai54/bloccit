Rails.application.routes.draw do
  resources :advertisements
  # #1 call the resources method and pass it a Symbol. This instructs Rails to create post routes for creating, updating, viewing, and deleting instances of "Post"
  resources :posts

  # #2 we remove "get "welcome/index" because we've declared the index view as the root view. We also modify the "about" route to allow users to visit "/about" rather than "/welcome/about"
  get 'about' => 'welcome#about'
  # 'root' declares the default page the app loads when we navigate to the home page URL. "root" is a method that takes a hash as an argument. here we use implied hash syntax instead of: root{{to: 'welcome#index'}}
  root 'welcome#index'

end
