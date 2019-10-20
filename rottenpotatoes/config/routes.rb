Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/movies/same_director/:id', to: 'movies#find_same_director', as: 'movies_with_same_director'

end
