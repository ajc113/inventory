Rails.application.routes.draw do
resources :locations

  resources :flavors do
    member do
      patch 'increase_inventory'
      patch 'decrease_inventory'
    end
  end

  resources :location_flavors do
    post :increase_inventory, on: :collection
    get :increase_inventory_form, on: :collection
  end


post 'location_flavors/increase_inventory', to: 'location_flavors#increase_inventory', as: 'location_flavors_increase_inventory'

get 'location_flavors/inventory_levels', to: 'location_flavors#inventory_levels', as: 'location_flavors_inventory_levels'


end






  