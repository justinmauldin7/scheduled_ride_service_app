class AddDriversToRides < ActiveRecord::Migration[7.0]
  def change
    add_reference :rides, :driver, foreign_key: true
  end
end
