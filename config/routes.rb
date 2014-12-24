Listenlog::Application.routes.draw do
  root 'angular_bootstrap#index'
  resources :concerts
  resources :artists

  resources :recordings do
    member do
      post 'start_listening'
      post 'pause_listening'
      post 'resume_listening'
      post 'finish_listening'
    end
  end
  resources :listen_events do
    collection do
      get 'last'
    end
  end

end
