Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/contact'
  # 'root' declares the default page the app loads when we navigate to the home page URL. "root" is a method that takes a hash as an argument. here we use implied hash syntax instead of: root{{to: 'welcome#index'}}
  root 'welcome#index'

end
