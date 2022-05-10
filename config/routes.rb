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

  resources :chirps, only: [:index, :show, :create, :update, :destroy, :new]
  # resources :chirps, except: [:new, :edit] # specify which routes to exclue (we'll learn about :new and :edit when we learn about views)
  # resources :chirps # creates all 7 restful routes for chirps


  # USERS ROUTES
    # html url, HTTP VERB, url path, controller method
    
    # users GET    /users(.:format)users#index
    # users POST   /users(.:format) users#create
    # new_user GET    /users/new(.:format) users#new
    # edit_user GET    /users/:id/edit(.:format) users#edit
    # user GET    /users/:id(.:format) users#show
    # user  PATCH  /users/:id(.:format) users#update
    # user PUT    /users/:id(.:format) users#update
    # user DELETE /users/:id(.:format) users#destroy
  resources :users

  resource :session, only: [:new, :create, :destroy]

end
