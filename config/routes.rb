Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Methods: get, post, patch/put, delete
  # Path

  # get '/chirps', to: 'chirps#index' # manually creating a single route
  # get '/chirps/:id', to: 'chirps#show' # ':id' is a wildcard
  # post '/chirps', to: 'chirps#create'
  # patch '/chirps/:id', to: 'chirps#update'
  # put '/chirps/:id', to: 'chirps#update'
  # delete '/chirps/:id', to: 'chirps#destroy'

  # resources <controller>, <actions_options>

    ## Routes with '/chirps' refer to a collection of chirps
    ## Routes with '/chirps/:id' refer to a specific (member) chirp

  # Shortcut for defining multiple routes with aliases:

  resources :chirps, only: [:index, :show, :create, :update, :destroy]
  # resources :chirps, except: [:new, :edit] # specify which routes to exclue (we'll learn about :new and :edit when we learn about views)
  # resources :chirps # creates all 7 restful routes for chirps

end
