Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create]
    end
  end

  namespace :admin do
    resources :products, only: %i[index edit update]
  end
end
