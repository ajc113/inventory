Rails.application.routes.draw do
  resources :locations

  resources :flavors



  resources :location_flavors do
  collection do
      get 'new_increase_inventory_form'
      post 'increase_inventory'
      get 'decrease_inventory'
      patch 'update_inventory'
    end
  end

  get 'location_flavors/inventory_levels', to: 'location_flavors#inventory_levels', as: 'location_flavors_inventory_levels'
end