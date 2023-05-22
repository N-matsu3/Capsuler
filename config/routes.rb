Rails.application.routes.draw do

  namespace :public do

  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
}

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}


##ユーザ
scope module: :public do
#homes
  root to: "homes#top"
  get "about" => "homes#about"

#users
  get "users/my_page" => "users#show"
  get "users/my_page/edit" => "users#edit"
  patch "users/my_page" => "users#update"

#items
  resources :items, only:[:index, :new, :create, :show,:destory, :myindex]
  get "my_items" => "items#myindex"

end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
