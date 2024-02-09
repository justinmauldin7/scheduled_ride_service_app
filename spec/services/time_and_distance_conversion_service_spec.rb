require 'rails_helper'

describe 'Time And Distance Conversion Service' do
  let(:duration_to_convert) { 113 }
  let(:distance_to_convert) { 531 }
  let(:hours_to_convert) { 0.12 }

  it 'can convert seconds into hours' do
    seconds_in_a_hour = 3600

    expected_value = duration_to_convert.to_f / seconds_in_a_hour.to_f

    converted_value = TimeAndDistanceConversionService.convert_seconds_to_hours(duration_to_convert)

    expect(converted_value).to be_an(Float)
    expect(converted_value).to eq(expected_value)

    expect(converted_value).not_to be_an(String)
    expect(converted_value).not_to eq(expected_value.to_s)
  end

  it 'can convert meters into miles' do
    meters_in_a_mile = 1609.344

    expected_value = distance_to_convert.to_f / meters_in_a_mile.to_f

    converted_value = TimeAndDistanceConversionService.convert_meters_to_miles(distance_to_convert)
 
    expect(converted_value).to be_an(Float)
    expect(converted_value).to eq(expected_value)
    
    expect(converted_value).not_to be_an(String)
    expect(converted_value).not_to eq(expected_value.to_s)
  end

  it 'can convert hours into minutes' do
    minutes_in_a_hour = 60

    expected_value = hours_to_convert.to_f * minutes_in_a_hour.to_f

    converted_value = TimeAndDistanceConversionService.convert_hours_to_minutes(hours_to_convert)

    expect(converted_value).to be_an(Float)
    expect(converted_value).to eq(expected_value)
    
    expect(converted_value).not_to be_an(String)
    expect(converted_value).not_to eq(expected_value.to_s)
  end
end