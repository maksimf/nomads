class NomadCitiesController < ApplicationController
  def index
    render json: NomadCity.all.as_json
  end
end
