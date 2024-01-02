class Api::V1::RidesController < ApplicationController
  before_action :get_driver

  def index
    rides = @driver.rides.order(score: :DESC)

    # We call "paginate" here instead of calling "render" so that we can use pagination on this endpoint, 
    # per the "api-pagination" gem's docs: https://github.com/davidcelis/api-pagination.
    paginate json: rides
  end

  private 

  def get_driver
    @driver = Driver.find_by_id(params[:driver_id])
  end
end   