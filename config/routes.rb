Rails.application.routes.draw do

	root 'pages#home'

	 devise_for :users, 
	  			:path => '', 
	  			:path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
	  			:controllers => {:omniauth_callbacks => 'omniauth_callbacks',
	  							 :registrations => 'registrations'
	  							}

	resources :users, only: [:show]
	resources :voitures
	resources :photos

	resources :voitures do 
		resources :reservations, only: [:create]
	end

	  resources :conversations, only: [:index, :create] do
	    resources :messages, only: [:index, :create]
	  end

	  resources :voitures do
	  	resources :reviews, only: [:create, :destroy]
	  end

	get '/preload' => 'reservations#preload'
	get '/preview' => 'reservations#preview'

	get '/vos_locations' =>'reservations#vos_locations'
	get '/vos_reservations' =>'reservations#vos_reservations'

	get'/search' => 'pages#search'

end
