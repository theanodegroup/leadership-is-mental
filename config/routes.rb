Rails.application.routes.draw do
  resources :articles, only: [:show, :destroy]
  resources :articles, path: 'admin/articles'
  resources :facebook_posts
  resources :leadership_articles
  resources :documents
  resources :leadership_jobs, path: 'admin/leadership_jobs'
  devise_for :users, path: 'admin/users'
  resources :messages, path: 'admin/messages'
  resources :carousel_images, path: 'admin/carousel_images'
  post 'update/quill', to: 'pages#quill_update', as: :quill_update
  post 'show/quill', to: 'pages#show_quill', as: :show_quill_editor

  resources :contacts, path: 'newsletter_signups'
  get 'blog', to: 'pages#blog', as: :blog
  get 'news', to: 'pages#news', as: :news
  get 'articles', to: 'pages#articles', as: :articles_page
  get 'contact', to: 'pages#contact', as: :contact_us
  get 'newsletter-signup', to: 'pages#newsletter_signup', as: :newsletter_signup

  get 'about', to: 'pages#about', as: :about
  get 'what-you-get', to: 'pages#what_you_get', as: :what_you_get
  get 'leadership-jobs', to: 'pages#leadership_jobs', as: :leadership_jobs_page
  get 'events', to: 'pages#events', as: :events
  get 'free-ebook', to: 'pages#free_ebook', as: :free_ebook

  get 'disclaimer', to: 'pages#disclaimer', as: :disclaimer
  get 'legal', to: 'pages#legal', as: :legal
  get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy
  get 'sitemap', to: 'pages#sitemap', as: :sitemap

  get 'settings', to: 'pages#settings', as: :settings

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
