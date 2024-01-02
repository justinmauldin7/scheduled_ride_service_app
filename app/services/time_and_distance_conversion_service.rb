class TimeAndDistanceConversionService
  def initialize 
    @seconds_in_a_hour = 3600
    @minutes_in_a_hour = 60

    @meters_in_a_mile = 1609.344
  end

  def convert_seconds_to_hours(integer_to_convert)
    divide_integer_by_a_value(integer_to_convert, @seconds_in_a_hour)
  end

  def convert_meters_to_miles (integer_to_convert)
    divide_integer_by_a_value(integer_to_convert, @meters_in_a_mile)
  end

  def convert_hours_to_minutes(integer_to_convert)
    multiply_integer_by_a_value(integer_to_convert, @minutes_in_a_hour)
  end

  private

  def divide_integer_by_a_value(integer_to_convert, value)
    # If we don't convert the integers into floats, any number that is retruned by the math 
    # that is less than 1 will be returned as 0 instead of a decimal.
    integer_to_convert.to_f / value.to_f
  end

  def multiply_integer_by_a_value(integer_to_convert, value) 
    # If we don't convert the integers into floats, any number that is retruned by the math 
    # that is less than 1 will be returned as 0 instead of a decimal. 
    integer_to_convert.to_f * value.to_f  
  end
end
