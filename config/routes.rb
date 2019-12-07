Rails.application.routes.draw do
  root to: 'shelters#index'

  get '/shelters', to: 'shelters#index'
  post '/shelters', to: 'shelters#create'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id/edit', to: 'shelters#edit'
  get '/shelters/:id', to: 'shelters#show'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  get '/shelters/:shelter_id/pets', to: 'pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  get '/shelters/:shelter_id/pets/:id', to: 'pets#show'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/shelters/:shelter_id/pets/:id/edit', to: 'pets#edit'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  post '/shelters/:shelter_id', to: 'reviews#create'

  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  get '/favorites', to: 'favorites#index'
end
