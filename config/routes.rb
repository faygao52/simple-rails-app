Rails.application.routes.draw do
  resources :users, only: [:index] do
    collection do
      post :import
    end
  end

  get '*path' => 'home#index'
  root to:'home#index'
end
