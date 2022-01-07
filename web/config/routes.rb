Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :api do
    get 'posts' => 'posts#index'
    get 'users/me' => 'users#me'
    post 'create' => 'users#create'
    post 'login' => 'users#login'
    post 'posts' => 'posts#create'
  end
end
