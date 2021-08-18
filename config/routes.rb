Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:edit, :update]

  resources :farms do
    resources :stocks
  end
  
  resources :groceries
<<<<<<< HEAD
  

=======

    get :my_farms, to: 'farms#my_farms'
>>>>>>> master
end
