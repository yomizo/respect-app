Rails.application.routes.draw do
  scope module: :v1 do
    resources :users
    resources :posts
    resources :metoos #, only:[:create, :destroy, :show]
  end
end
