class Ride < ApplicationRecord
  belongs_to :driver
  
  validates_presence_of :start_address, :end_address
end