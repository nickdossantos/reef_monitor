class Api::ReadingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    
    
    def create
        begin 
            decoded_data = Jsonwebtoken.decode(params[:token])
            payload = decoded_data[0]
            user = User.find_by(hash_id: payload['data']['user'])
            sensor = Sensor.find_by(hash_id: payload['data']['sensor'])
            reading = Reading.new
            reading.user_id = user.id
            reading.sensor_id = sensor.id
            reading.date = "10/10/2010"
            reading.value = payload['data']['value'].to_i
            reading.tank_id = sensor.tank.id
            if reading.save
                render json: {status: "SUCCESS", message: 'Your token has been decoded.', data: decoded_data}, status: :ok
            else 
                render json: {status: "FAIL", message: 'Your token has not been decoded.'}, status: :ok
            end 
        rescue
            render json: {status: "FAIL", message: 'Your token has not been decoded.'}, status: :ok
        end
        
    end 

    private
    def decode_token
       @decoded_data = Jsonwebtoken.decode(params[:token])
    end 
end