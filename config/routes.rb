Rails.application.routes.draw do
  post 'tickets/create', to:"ticket#create"
  # get 'tickets/index', to:"ticket#index"
  # get 'tickets/show/:id', to:"ticket#show"
  delete 'tickets/destroy/:id', to:"ticket#destroy"
  post 'reviews/create', to:"review#create"
  get 'reviews/index', to:"review#index"
  # get 'reviews/show/:id', to:"review#show"
  delete 'reviews/destroy/:id', to:"review#destroy"
  get 'venues/index', to:"venue#index"
  # get 'venues/show/:id', to:"venue#show"
  get 'venue_events/index', to:"venue_event#index"
  # get 'venue_events/show/:id', to:"venue_event#show"
  get 'events/index', to:"event#index"
  # get 'events/show/:id', to:"event#show"
  post '/register', to:"user#create"
  # get 'users/index', to:"user#index"
  # patch 'user/update/:id',to:"user#update"
  get 'users/show/:id', to:"user#show"
  patch'users/edit/:id', to:"user#edit"
  # delete 'users/destroy/:id', to:"user#destroy"
  post'login',to:"auth#login"
  post'auto_login',to:"auth#autologin"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
