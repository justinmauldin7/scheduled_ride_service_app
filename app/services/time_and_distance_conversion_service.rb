class TimeAndDistanceConversionService
  def initialize(integer_to_convert) 
    @integer_to_convert = integer_to_convert
  end

  def convert_seconds_to_hours 
    seconds_in_a_hour = 3600

    # If we don't convert the integers into floats, any number that is retruned by the math 
    # that is less than 1 will be returned as 0 instead of a decimal.
    hours_as_float = @integer_to_convert.to_f / seconds_in_a_hour.to_f

    format_decimal_places(hours_as_float)
  end

  def convert_meters_to_miles 
    meters_in_a_mile = 1609.344

    # If we don't convert the integers into floats, any number that is retruned by the math 
    # that is less than 1 will be returned as 0 instead of a decimal.
    miles_as_float = @integer_to_convert.to_f / meters_in_a_mile.to_f

    format_decimal_places(miles_as_float)
  end

  private

  def format_decimal_places(value)
    # This will convert our float into a string & return only 2 decimal places. 
    # EX: 0.0313888 turns into "0.03"
    # It also makes sure it ends in a 0 if needed for consistant formatting.
    # EX: 0.401 turns into "0.40"
    '%.2f' % value
  end
end
