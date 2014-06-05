Myflix::Application.routes.draw do
  get 'categories/show'

  resources :videos, only: [:index, :show]
  resources :categories, only: :show
  get 'ui(/:action)', controller: 'ui'
  
  root 'videos#index'
end
