class DashboardController < ApplicationController
  before_action :authenticate_user!
  require 'net/http'
  def show
    @tank = @user.tanks.find(params[:tank_id])
    @sensor = @user.sensors.new
    @reading = @user.readings.new
    if @tank.temp_sensor_id && @tank.temp_sensor_pin

      url = URI.parse(@user.api_endpoint << "/api/get_temperature_reading?token=" << Jsonwebtoken.encode_user_for_temperature_request(@user, @tank))
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      puts res.body
      data = JSON.parse(res.body)
      @farenheit = data['farenheit']
    end 
  end
end
