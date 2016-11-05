Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'commons#welcome'
  get '/code'=>'commons#code'

  devise_for :users

  get '/sponsor'=>"users#sponsor"
  get '/user' => 'users#home'
  get '/user/node' => 'users#node'
  get '/user/profile' => 'users#profile'
  get '/user/traffic' => 'users#traffic'
  get '/user/edit' => 'users#change'
  get '/user/invite' => 'users#invite'
  post '/user/password'=>'users#change_password'
  post '/user/connectPassword'=>'users#change_connect_password'
  post '/user/change_username'=>'users#change_username'
  patch '/user/avatar'=>'users#avatar'
  delete '/user'=>'users#destroy'
  mount ActionCable.server => '/cable'


  post '/checkin'=>'users#check_in'
  get '/admin'=>"admin#index"
  namespace :admin do
    get 'traffic'
    get 'configuration'
    post 'configuration'
    post 'invite'
    resources :users
    resources :nodes
    get 'search'
  end
end
