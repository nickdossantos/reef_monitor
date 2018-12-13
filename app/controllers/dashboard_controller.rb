class DashboardController < ApplicationController
  before_action :authenticate_user!
  def show
    @tank = @user.tanks.find(params[:tank_id])
    @sensor = @user.sensors.new
    @reading = @user.readings.new
  end
end
