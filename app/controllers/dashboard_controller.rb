class DashboardController < ApplicationController
  before_action :authenticate_user!
  def show
    @tank = @user.tanks.new
    @sensor = @user.sensors.new
    @reading = @user.readings.new
  end
end
