Rails.application.routes.draw do
  devise_for :accounts
  get "u/:username" => "public#profile", as: :profile
  resources :communities do
    resources :posts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "public#index"
end
