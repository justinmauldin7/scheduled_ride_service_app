class TimeAndDistanceConversionService
  def initialize 
    @seconds_in_a_hour = 3600
    @meters_in_a_mile = 1609.344
  end

  def convert_seconds_to_hours(integer_to_convert)
    divide_integer_by_a_value(integer_to_convert, @seconds_in_a_hour)
  end

  def convert_meters_to_miles (integer_to_convert)
    divide_integer_by_a_value(integer_to_convert, @meters_in_a_mile)
  end

  private

  def divide_integer_by_a_value(integer_to_convert, value)
    # If we don't convert the integers into floats, any number that is retruned by the math 
    # that is less than 1 will be returned as 0 instead of a decimal.
    converted_float = integer_to_convert.to_f / value.to_f

    format_decimal_places(converted_float)
  end

  def format_decimal_places(value)
    # This will convert our float into a string & return only 2 decimal places. 
    # EX: 0.0313888 turns into "0.03"
    # It also makes sure it ends in a 0 if needed for consistant formatting.
    # EX: 0.401 turns into "0.40"
    '%.2f' % value
  end
end
