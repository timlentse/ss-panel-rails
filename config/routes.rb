Rails.application.routes.draw do
  get 'nodes/create'

  get 'nodes/edit'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'commons#welcome'

  get '/login'=>'authentications#login'
  post '/login'=>'authentications#login'
  get '/logout'=>'authentications#logout'
  get '/register'=>"authentications#register"
  post '/register'=>"authentications#register"
  get '/password/reset'=>"authentications#password_reset"
  post '/password/reset'=>"authentications#password_reset"
  get '/password/token/:token'=>'authentications#password_token'
  post '/password/token/:token'=>'authentications#password_token'
  get '/verify'=>"authentications#verify"

  get '/user' => 'users#index'
  get '/user/node' => 'users#node'
  get '/user/profile' => 'users#profile'
  get '/user/traffic' => 'users#traffic'
  get '/user/edit' => 'users#edit'
  get '/user/invite' => 'users#invite'
  post '/user/comments'=>'users#comments'
  post '/user/password'=>'users#change_password'
  post '/user/connectPassword'=>'users#change_connect_password'

  post '/checkin'=>'users#check_in'

  get '/admins'=>'admins#admin'
  namespace :admins do 
    get 'node'
    get 'traffic'
    get 'user'
    get 'configuration'
  end
  resources :nodes
end
