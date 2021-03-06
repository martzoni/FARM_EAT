Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:edit, :update]

  resources :farms do
    resources :stocks
  end
  
  resources :groceries do
    resources :grocery_products
  end

  get :my_farms, to: 'farms#my_farms'
  get :my_groceries, to: 'groceries#my_groceries'
end
