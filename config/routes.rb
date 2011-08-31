Peeps::Application.routes.draw do
  resources :users
  match "/users/me/edit" => "users#edit", :as => "edit_your_user"
  #match "/users/me/get_photos" => "users#get_photos"
  match "/sessions/destroy" => "sessions#destroy"
  root :to => "users#index"
  
  # Omniauth
  match "/auth/failure" => "sessions#failure"
  match "/auth/:provider/callback" => "sessions#callback", :as => "provider_callback"
end
