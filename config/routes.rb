Rails.application.routes.draw do
    defaults format: :json do
		resources :genres
		resources :authors
		resources :books do
			resources :reviews
		end
		get 'search' => "home#search"
		post "login" => "home#login"
		post "sign_up" => "home#sign_up"
	end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
