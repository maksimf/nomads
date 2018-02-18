class NomadCitiesController < ApplicationController
  def index
    headers['Access-Control-Allow-Origin'] = '*'
    
    render json: NomadCity.all.as_json
  end
end
