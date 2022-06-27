Rails.application.routes.draw do
  resources :lights do
    member do
      post :set_color
    end
  end
  resources :rooms do
    member do
      post :say
      get :tell_joke
      get :toggle_say_service
    end
  end
  
  resources :door_messages do 
    collection do
      get :get_message
    end
  end

  resources :skunk_works do
    collection do
      get :say_randomly
    end
  end

  root 'rooms#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
