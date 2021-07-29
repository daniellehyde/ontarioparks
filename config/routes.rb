Rails.application.routes.draw do
  root "parks#index"

  resources :parks do
    resources :campsites
  end
end