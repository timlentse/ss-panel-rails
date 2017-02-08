Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'commons#welcome'
  get '/code'=>'commons#code'

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  get '/sponsor'=>"users#sponsor"

  scope :user do
    root "users#home"
    get '/node' => 'users#node'
    get '/profile' => 'users#profile'
    get '/traffic' => 'users#traffic'
    get '/edit' => 'users#change'
    get '/invite' => 'users#invite'
    post '/password'=>'users#change_password'
    post '/connectPassword'=>'users#change_connect_password'
    post '/change_username'=>'users#change_username'
    patch '/avatar'=>'users#avatar'
    delete '/'=>'users#destroy'
  end

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
