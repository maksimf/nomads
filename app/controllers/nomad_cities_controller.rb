class NomadCitiesController < ApplicationController
  def index
    headers['Access-Control-Allow-Origin'] = '*'

    render json: NomadCity.all_without_duplicates.as_json
  end
end
