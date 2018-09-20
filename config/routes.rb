Rails.application.routes.draw do
  resources :armor
  resources :helmets

  get "/armor/:parent_id/new", to: "helmets#new", as: :new_child_helmet
end
