Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, except: [ :new, :edit, :update ] do
        post "borrow", on: :member
        patch "return", on: :member
      end
    end
  end
end
