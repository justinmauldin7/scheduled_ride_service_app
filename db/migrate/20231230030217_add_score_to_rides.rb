class AddScoreToRides < ActiveRecord::Migration[7.0]
  def change
    add_column :rides, :score, :float
  end
end
