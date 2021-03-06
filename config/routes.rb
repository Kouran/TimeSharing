Rails.application.routes.draw do

  resources :user_platform_data

  resources :personal_data

  resources :transactions

  resources :messages
  resources :users
  resources :ads

	root 'welcome#home'
	#get "welcome/homepage" => "welcome#homepage"
    	get "welcome/result" => "ads#result"
	#messages/index.html.erb
	get "messages" => "messages#index"
  get "/messages/new/:to" => "messages#new"
	#aggiungere queste routes
	get "/admin_report" => "messages#admin_report"		#Invia messaggi a Admin

	#get "/messages/mod_report" => "messages#reportToMod"		Invia messaggi a Mod
	get "/adminmessages" => "messages#admin"
	get "/modmessages" => "messages#mod"
	#get "/modmessages" => "messages#modShow"				Visualizza messaggi a Mod
	#get "/messages/search" => "messages#searchForAdmin"				Ricerca Messaggi per l'Admin

	#route per la registrazione
	get "/signup" => "users#new"
	post "/signup" => "users#create"
	#sessione per il login
	get "/login" => "sessions#new"
	post "/login" => "sessions#create"
	delete "/logout" => "sessions#destroy"
	#route per gli ads
	get"Ads/Search" => "ads#search"
	get "Ads/Result" => "ads#result"
	get "Ads/My" => "ads#my"
	get "Ads/New" => "ads#new"
	#route per contatti
	get "welcome/contatti" => "welcome#contatti"
	get "/help" => "welcome#help"

	#prova per telegram
	post "/webhook" => "webhook#receive"


	#Aggiungere una route per creare le transazioni
	post "Ads/close/:id" => "transactions#new"
    #post "/transactions/create" => "transactions#new"

	#route per le pagine di amministrazione
	get "/admin" => "administration#admin"
	get "/mod" => "administration#mod"
	post "/user_platform_data/permission" => "user_platform_data#permission"
	post "/user_platform_data/wallet" => "user_platform_data#wallet"
	post "/users/nick_destroy" => "users#nick_destroy"
	post "/Ads/delete" => "ads#param_delete"
	get "/unauthorized" => "administration#unauthorized"



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end




end
