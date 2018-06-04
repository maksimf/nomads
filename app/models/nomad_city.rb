class NomadCity
  include Mongoid::Document
  store_in collection: 'nomadCities'

  field :user, type: String
  field :nickname, type: String
  field :city, type: String
  field :country, type: String
  field :lat, type: Float
  field :lng, type: Float

  def as_json
    {
      id: _id.to_s,
      user: nickname || user,
      city: city,
      country: country,
      lat: lat,
      lng: lng
    }
  end

  def coord
    "#{self.lat},#{self.lng}"
  end

  def self.all_without_duplicates
    objects = all.to_a
    objects.each_with_object([]) do |record, acc|
      # Do not record duplicated locations twice
      next if acc.find { |obj| obj.coord == record.coord }

      # Find all NomadCities objects with same lat/lng pair
      same_location = objects.find_all { |obj| record.coord == obj.coord }

      # If current NomadCity object is unique (only 1 user in this location),
      # then push and continue iteration
      (acc.push(record) && next) if same_location.length == 1

      # Make comma-separated string of nicknames/ids of the nomads in the same city
      nicknames = same_location.pluck(:nickname).join(', ')
      ids = same_location.pluck(:user).join(', ')

      # Take first record as an object where we will put our merged string of nicknames
      merged_nomad_city = same_location[0]
      merged_nomad_city.attributes.merge!(
        nickname: nicknames,
        user: ids
      )

      acc.push(merged_nomad_city)
    end
  end
end
