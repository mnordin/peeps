Peeps::Application.routes.draw do

  match "/sessions/google_apps_callback" => "sessions#google_apps_callback", :as => "google_app_callback"
  match "/sessions/destroy" => "sessions#destroy"
  
  
  match "/users/me/edit" => "users#edit", :as => "edit_your_user"
  match "/users/me/get_photos" => "users#get_photos"
  resources :users
  #match "/users/" => "users#index", :as => "users"
  #match "/users/:id/show" => "users#show", :as => "user"
  #match "/users/edit" => "users#edit", :as => "edit_user"
  #match "/users/update" => "users#update", :via => :put
  root :to => "users#index"
  
  # Omniauth
  match "/auth/failure" => "sessions#failure"

end
