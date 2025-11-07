Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Root
  root "dashboard#index"

  # Dashboard
  get 'dashboard', to: 'dashboard#index'
  get 'dashboard/all_genres', to: 'dashboard#all_genres', as: 'all_genres'
  get 'dashboard/all_years', to: 'dashboard#all_years', as: 'all_years'
  get 'dashboard/all_countries', to: 'dashboard#all_countries', as: 'all_countries'
  get 'dashboard/by_genre/:id', to: 'dashboard#by_genre', as: 'media_by_genre'
  get 'dashboard/by_year/:year', to: 'dashboard#by_year', as: 'media_by_year'
  get 'dashboard/by_country/:id', to: 'dashboard#by_country', as: 'media_by_country'

  resources :media_physicals do
    collection do
      get :search
    end

    # Nested routes for tracks
    resources :tracks do
      collection do
        post :bulk_create
      end
    end
  end

  # Lookup tables
  resources :genres
  resources :record_labels
  resources :imprints
  resources :countries
  resources :media_types
  resources :release_types
  resources :cassette_types
  resources :cassette_durations
end
