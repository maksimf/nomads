class NomadCity
  include Mongoid::Document
  store_in collection: 'nomadCities'

  field :user, type: String
  field :city, type: String
  field :country, type: String
  field :lat, type: Float
  field :lng, type: Float

  def as_json
    {
      id: _id.to_s,
      user: user,
      city: city,
      country: country,
      lat: lat,
      lng: lng
    }
  end
end
