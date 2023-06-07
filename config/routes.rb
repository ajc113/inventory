Rails.application.routes.draw do
  resources :locations
 resources :flavors do
  member do
    patch 'increase_inventory'
    patch 'decrease_inventory'
  end
end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
