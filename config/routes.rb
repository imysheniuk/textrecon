Textrecon::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "welcome/index"
  get "welcome/about"

  
  
  root to: 'welcome#index'
end
