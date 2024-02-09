class TimeAndDistanceConversionService
  class << self
    SECONDS_IN_A_HOUR = 3600
    MINUTES_IN_A_HOUR = 60
    METERS_IN_A_MILE = 1609.344
  
    def convert_seconds_to_hours(integer_to_convert)
      divide_integer_by_a_value(integer_to_convert, SECONDS_IN_A_HOUR)
    end
  
    def convert_meters_to_miles (integer_to_convert)
      divide_integer_by_a_value(integer_to_convert, METERS_IN_A_MILE)
    end
  
    def convert_hours_to_minutes(integer_to_convert)
      multiply_integer_by_a_value(integer_to_convert, MINUTES_IN_A_HOUR)
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
end
