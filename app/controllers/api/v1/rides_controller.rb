class Api::V1::RidesController < ApplicationController
  before_action :get_driver

  def index
    rides = @driver.rides

    render json: rides
  end

  private 

  def get_driver
    @driver = Driver.find_by_id(params[:driver_id])
  end
end