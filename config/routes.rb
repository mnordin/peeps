Peeps::Application.routes.draw do

  get "score/index"
  #get "score/highscores/", :as => "highscore"
  match "/score/highscore/:office", :controller => "score", :action => "highscore", :as => "highscore"
  post "score/create", :as => "submit_score"

  resources :users
  match "/users/me/edit" => "users#edit", :as => "edit_your_user"
  match "/users/" => "users#index", :as => "change_game_locale"
  match "/sessions/destroy" => "sessions#destroy"
  root :to => "users#index"
  
  # Omniauth
  match "/auth/failure" => "sessions#failure"
  match "/auth/:provider/callback" => "sessions#callback", :as => "provider_callback"
end