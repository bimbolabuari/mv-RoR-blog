Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "blog_users#user"
  get "/users/", to: "blog_users#user"
  get "/users/:id", to: "blog_users#profile"
  get "/users/:id/posts", to: "blog_posts#posts"
  get "/users/:id/posts/:id", to: "blog_posts#post"
end
