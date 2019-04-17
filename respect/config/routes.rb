Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1 do
    resources :users
    resources :posts
    resources :metoos
  end
end
