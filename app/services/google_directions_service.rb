class GoogleDirectionsService
  API_KEY = ENV['GOOGLE_MAPS_API_KEY'].freeze

  def self.get_raw_directions_data(driver_address, start_address, end_address)
    get_json("/maps/api/directions/json?origin=#{driver_address}&waypoints=#{start_address}&destination=#{end_address}")
  end

  def self.get_serialized_directions_data(driver_address, start_address, end_address)
    raw_data = get_raw_directions_data(driver_address, start_address, end_address)

    get_distance_and_duration_data(raw_data)
  end

  private

  def self.conn
    Faraday.new(:url => 'https://maps.googleapis.com') do |faraday|
      faraday.params['key'] = API_KEY
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.get_json(path)
    response = conn.get(path)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_distance_and_duration_data(raw_data)
    route_legs = raw_data[:routes].first[:legs]
    cleaned_route_array = []

    route_legs.each do |leg|
      distance_and_duration_hash = leg.slice(:distance, :duration)

      cleaned_route_array << distance_and_duration_hash
    end

    cleaned_route_array
  end 
end