Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get "/users/", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/posts", to: "posts#index"
  get "/users/:id/posts/:id", to: "posts#show"
  get "/users/:id/posts/new", to: "posts#new"
  post "/users/:id/posts", to: "posts#create"
  post "/users/:id/posts/:id/likes", to: "likes#create"
  post "/users/:id/posts/:id/comments", to: "comments#create"
  get "/users/:id/posts/:id/comments/new", to: "comments#new"
end
