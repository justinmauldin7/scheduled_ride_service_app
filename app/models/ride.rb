class Ride < ApplicationRecord
  belongs_to :driver
  
  validates_presence_of :start_address, :end_address

  after_create :set_ride_score

  def set_ride_score
    # This logic will protect against making unwanted calls to the Google Directions API,
    # in case this method is accidently called other than at record creation.
    if self.score == nil
      cleaned_route_data = GoogleDirectionsService.get_cleaned_ride_routing_data(self.driver.address, self.start_address, self.end_address)
      
      ride_score_service = RideScoreCalculatorService.new(cleaned_route_data)
      ride_score = ride_score_service.get_ride_score

      self.update(score: ride_score)
    else
      raise StandardError.new("ERROR: Ride score is already set.")
    end
  end
end
