Rails.application.routes.draw do
  root("parks#index")
  get("search", to:"search#search")

resources :parks do
    resources :campsites
  end
end