class RideScoreCalculatorService
  BASE_RIDE_FEE = 12.freeze # this value is in dollars
  BASE_RIDE_DISTANCE = 5.freeze # this value is in miles
  BASE_RIDE_DURATION = 15.freeze # this value is in minutes
  EXTRA_DURATION_RATE = 0.70.freeze # this value is in dollars
  EXTRA_DISTANCE_RATE = 1.50.freeze # this value is in dollars

  def initialize(route_data)
    @conversion_service = TimeAndDistanceConversionService.new

    @commute_duration = convert_duration_to_hours(route_data.first[:duration])
    @ride_duration = convert_duration_to_hours(route_data.last[:duration])

    @commute_distance = convert_distance_to_miles(route_data.first[:distance])
    @ride_distance = convert_distance_to_miles(route_data.last[:distance])

    @total_ride_duration = (@commute_duration + @ride_duration)
    @total_ride_distance = (@commute_distance + @ride_distance)
 
    @extra_duration_charge = get_extra_duration_charge # this value is in dollars
    @extra_distance_charge = get_extra_distance_charge # this value is in dollars
  end

  def get_ride_score
    # The score of a ride is calculated in $ per hour.
    # It is calculated as: 
    # (ride earnings) / (commute duration + ride duration) 
    raw_ride_score = get_ride_earnings / @total_ride_duration
    format_decimal_places(raw_ride_score)
  end

  def get_ride_earnings
    # The ride earnings is how much the driver earns by driving the ride. 
    # It takes into account both the amount of time the ride is expected to take and the distance. 
    # It is calculated as: 
    # $12 + $1.50 per mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes
    (BASE_RIDE_FEE + @extra_distance_charge + @ride_duration) * @extra_duration_charge
  end

  private 

  def convert_duration_to_hours(duration)
    @conversion_service.convert_seconds_to_hours(duration)
  end

  def convert_distance_to_miles(distance)
    @conversion_service.convert_meters_to_miles(distance)
  end

  def get_extra_duration_charge
    # $0.70 per minute beyond 15 minutes

    # @total_ride_duration is in hours, so we need to convert it into minutes.
    total_ride_minutes =  @conversion_service.convert_hours_to_minutes(@total_ride_duration)

    if total_ride_minutes > BASE_RIDE_DURATION
      extra_minutes = total_ride_minutes - BASE_RIDE_DURATION

      return EXTRA_DURATION_RATE * extra_minutes
    else
      # We need to return 1 hear instead of 0, because you can't divide something by 0,
      # which is what we are doing with this return value in the "get_ride_earnings" method.
      return 1
    end
  end

  def get_extra_distance_charge
    # $1.50 per mile beyond 5 miles

    if @total_ride_distance > BASE_RIDE_DISTANCE
      extra_miles = @total_ride_distance - BASE_RIDE_DISTANCE

      return EXTRA_DISTANCE_RATE * extra_miles
    else
      # This returned value can be 0 because we are just doing addition with the value in the "get_ride_earnings" method.
      return 0
    end
  end

  def format_decimal_places(value)
    # This will convert our float into a string & return only 2 decimal places. 
    # EX: 0.0313888 turns into "0.03"
    # It also makes sure it ends in a 0 if needed for consistent formatting.
    # EX: 0.401 turns into "0.40"
    '%.2f' % value
  end
end