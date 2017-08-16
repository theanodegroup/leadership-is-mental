Rails.application.routes.draw do
  resources :messages
  resources :carousel_images
  post 'pages/update/quill', to: 'pages#quill_update', as: :quill_update
  post 'pages/show/quill', to: 'pages#show_quill', as: :show_quill_editor

  resources :contacts, path: 'newsletter_signups'
  get 'pages/blog', to: 'pages#blog', as: :blog
  get 'pages/contact', to: 'pages#contact', as: :contact_us
  get 'pages/newsletter-signup', to: 'pages#newsletter_signup', as: :newsletter_signup

  get 'pages/about', to: 'pages#about', as: :about
  get 'pages/what-you-get', to: 'pages#what_you_get', as: :what_you_get
  get 'pages/leadership-jobs', to: 'pages#leadership_jobs', as: :leadership_jobs
  get 'pages/events', to: 'pages#events', as: :events
  get 'pages/free-ebook', to: 'pages#free_ebook', as: :free_ebook

  get 'pages/disclaimer', to: 'pages#disclaimer', as: :disclaimer
  get 'pages/legal', to: 'pages#legal', as: :legal
  get 'pages/terms_of_use', to: 'pages#terms_of_use', as: :terms_of_use
  get 'pages/sitemap', to: 'pages#sitemap', as: :sitemap

  root 'pages#home'
end

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
