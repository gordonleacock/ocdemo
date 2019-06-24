Rails.application.routes.draw do
  resources :armor
  resources :helmets
  resources :collection
  resources :items

  get "/armor/:parent_id/new", to: "helmets#new", as: :new_child_helmet
  get "/file/:resource_id", to: "files#show", as: :show_file

  get "/collection/:parent_id/new", to: "items#new", as: :new_child_item
end
