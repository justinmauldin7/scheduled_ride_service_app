class Driver < ApplicationRecord
  has_many :rides

  validates_presence_of :address
end