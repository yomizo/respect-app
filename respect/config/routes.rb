Rails.application.routes.draw do
  scope module: :v1 do
    resources :users
    resources :posts
    resources :metoos , only:[:index, :create, :destroy, :show]
    post '/signin', to: 'sessions#signin'
    post '/posts/search', to: 'posts#search'
  end
end
