Rails.application.routes.draw do

  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
}

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

scope module: :public do
#homes
  root to: "homes#top"
  get "about" => "homes#about"

#users
  get "users/my_page" => "users#show"


end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
