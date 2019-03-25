class Api::ReadingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    
    def create
        begin 
            decoded_data = Jsonwebtoken.decode(params[:jwt_token])
            payload = decoded_data[0]
            user = User.find_by(hash_id: payload['user'])
            sensor = Sensor.find_by(hash_id: payload['sensor'])

            reading = ReadingService.create_reading(user, payload['date'], payload['hour'], payload['minute'], payload['value'], sensor.id, sensor.tank_id)
            if reading.save
                render json: {status: "SUCCESS", message: 'Your token has been decoded.', data: decoded_data}, status: :ok
            else 
                render json: {status: "FAIL", message: 'Your token has not been decoded.'}, status: :ok
            end 
        rescue => e 
            render json: {status: "FAIL", message: e}, status: :ok
        end
        
    end 
end