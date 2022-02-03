Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :api do
    get 'posts' => 'posts#index'#投稿の一覧表示 http://localhost:3000/api/posts
    post 'create' => 'users#create'
    post 'login' => 'users#login'
    post 'posts' => 'posts#create'
  end
end
