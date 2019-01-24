class DashboardController < ApplicationController
  before_action :authenticate_user!
  require 'net/http'
  def show
    @tank = @user.tanks.find(params[:tank_id])
    @sensor = @user.sensors.new
    @reading = @user.readings.new
    puts "starting get"
    if @tank.temp_sensor_id && @tank.temp_sensor_pin
      @farenheit = TemperatureService.get_temperature(@user, @tank)
    end 
  end
end
