Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "websites#index"

  resources :websites, only: [:create] do
    collection do
      get :popular_websites
    end
  end

  get ':slug', to: 'websites#show'
end
