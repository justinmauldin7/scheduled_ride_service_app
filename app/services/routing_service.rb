class RoutingService
  class << self
    API_KEY = ENV['GOOGLE_MAPS_API_KEY'].freeze
    ROUTING_API_URL = 'https://maps.googleapis.com'.freeze
  
    def get_raw_directions_data(driver_address, start_address, end_address)
      # Here is a link to the Google Directions API Docs that shows what the response of this API call looks like: 
      # https://developers.google.com/maps/documentation/directions/get-directions#DirectionsResponses
      get_json("/maps/api/directions/json?origin=#{driver_address}&waypoints=#{start_address}&destination=#{end_address}")
    end
  
    def get_serialized_directions_data(driver_address, start_address, end_address)
      # This method returns only a raw version of the "duration" & "distance" data found in the "legs" secion from the raw data.
      # The data will look like this:
      # [{:distance=>{:text=>"0.3 mi", :value=>531}, :duration=>{:text=>"2 mins", :value=>113}}, 
      # {:distance=>{:text=>"1.3 mi", :value=>2058}, :duration=>{:text=>"5 mins", :value=>319}}]
      raw_data = get_raw_directions_data(driver_address, start_address, end_address)
  
      get_distance_and_duration_data(raw_data)
    end
  
    def get_cleaned_ride_routing_data(driver_address, start_address, end_address)
      # This method returns only a cleaned up version of the "duration" & "distance" data found in the "legs" secion from the raw data.
      # The data will look like this:
      # [{:distance=>531, :duration=>113}, {:distance=>2058, :duration=>319}]
      raw_distance_and_duration_data = get_serialized_directions_data(driver_address, start_address, end_address)
  
      get_cleaned_distance_and_duration_data(raw_distance_and_duration_data)
    end
  
    private
  
    def conn
      Faraday.new(:url => ROUTING_API_URL) do |faraday|
        faraday.params['key'] = API_KEY
        faraday.adapter  Faraday.default_adapter
      end
    end
  
    def get_json(path)
      response = conn.get(path)
      JSON.parse(response.body, symbolize_names: true)
    end
  
    def get_distance_and_duration_data(raw_data)
      route_legs = raw_data[:routes].first[:legs]
  
      route_legs.map do |leg|
        leg.slice(:distance, :duration)
      end
    end
  
    def get_cleaned_distance_and_duration_data(raw_data)
      raw_data.map do |route_data|
        {
          distance: route_data[:distance][:value],
          duration: route_data[:duration][:value]
        }
      end
    end
  end
end