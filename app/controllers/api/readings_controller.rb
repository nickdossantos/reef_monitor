class Api::ReadingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    def create
        begin 
            decoded_data = Jsonwebtoken.decode(params[:token])
            payload = decoded_data[0]           
            user = User.find_by(token: payload['auth_token'])
            sensor = Sensor.find_by(hash_id: payload['temp_sensor_hash'])
            reading = ReadingService.create_reading(user, sensor, payload['reading_data'])

            if reading.save
                render json: {status: "SUCCESS", message: 'Your reading has been created.', data: decoded_data}, status: :ok
            else 
                render json: {status: "FAIL", message: 'Your token has not been decoded.', data: decoded_data}, status: :ok
            end 
            
        rescue => e 
            render json: {status: "FAIL", message: e, data: decoded_data}, status: :ok
        end        
    end 
end