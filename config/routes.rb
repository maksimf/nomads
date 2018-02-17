Rails.application.routes.draw do
  root 'nomad_cities#index'

  get 'nomad_cities/index'
end
