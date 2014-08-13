Textrecon::Application.routes.draw do
  
  resources :messages, only: [:new, :create, :show]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get "welcome/about"
  
  root to: 'welcome#index'
end
