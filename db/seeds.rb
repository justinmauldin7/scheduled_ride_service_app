# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

driver_1 = Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012")
puts "Created Driver."

Ride.create(driver: driver_1, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
            end_address:"1550 S Potomac St, Aurora, CO 80012")

Ride.create(driver: driver_1, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012", 
            end_address:"200 S Ironton St, Aurora, CO 80012")

Ride.create(driver: driver_1, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012", 
            end_address:"8580 E Lowry Blvd, Denver, CO 80230")

Ride.create(driver: driver_1, 
            start_address:"12051 E Arizona Ave. Aurora, CO 80012", 
            end_address:"8580 E Lowry Blvd, Denver, CO 80230")
puts "Created Rides."