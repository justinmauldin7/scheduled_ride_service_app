class Ride < ApplicationRecord
  validates_presence_of :start_address, :end_address
end