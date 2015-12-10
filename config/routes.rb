Rails.application.routes.draw do
  devise_for :users
  get 'user/new'

  get 'user/create'

  get 'user/index'

  get 'welcome/index'

  get 'welcome/about'

  root to: 'welcome#index'

  resources :users
end
