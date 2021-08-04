Rails.application.routes.draw do 
  devise_for :users
  resources :cocktails 
  get 'home/about'  
  get 'home/contact' 
  root "home#index" 
  # root to: "cocktails#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
