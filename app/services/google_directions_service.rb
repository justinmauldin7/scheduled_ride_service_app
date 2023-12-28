class GoogleDirectionsService
  API_KEY = ENV['GOOGLE_MAPS_API_KEY'].freeze

  def self.get_directions_data(start_address, end_address)
    get_json("/maps/api/directions/json?origin=#{start_address}&destination=#{end_address}")
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
end