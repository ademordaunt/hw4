Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  get("/", { :controller => "places", :action => "index" })
  get "/logout", { controller: "sessions", action: "destroy" }
  get "/login", { controller: "sessions", action: "new" }
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"
end
