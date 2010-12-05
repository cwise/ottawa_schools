OttawaSchools::Application.routes.draw do
  match 'home/search'

  root :to => 'home#index'
end
