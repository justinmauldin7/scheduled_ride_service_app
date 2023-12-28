class GoogleDirectionsService
  def initialize(start_address, end_address)
    @start_address = start_address
    @end_address = end_address
  end

  def get_directions_data
    get_json("/maps/api/directions/json?origin=#{@start_address}&destination=#{@end_address}")
  end

  private

  def conn
    Faraday.new(:url => 'https://maps.googleapis.com') do |faraday|
      faraday.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_json(path)
    response = conn.get(path)
    JSON.parse(response.body, symbolize_names: true)
  end
end