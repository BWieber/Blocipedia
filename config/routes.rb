Rails.application.routes.draw do

  get 'charges/create'

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root to: 'welcome#index'

  resources :users

  resources :wikis

  resources :charges, only: [:new, :create]

end
