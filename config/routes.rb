Listenlog::Application.routes.draw do
  root 'angular_bootstrap#index'
  resources :concerts
  resources :artists

  resources :recordings do
    member do
      post 'start_listening'
      post 'finish_listening'
    end
  end
  resources :listen_events

end
