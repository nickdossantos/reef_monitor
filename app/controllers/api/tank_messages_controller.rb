class Api::TankMessagesController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    def notify_sms_out_of_range
        begin 
            decoded_data = Jsonwebtoken.decode(params[:token])
            payload = decoded_data[0]           

            user = User.find_by(token: payload['auth_token'])
            sensor = Sensor.find_by(hash_id: payload['temp_sensor_hash'])
    
            reading = payload['reading_data']['farenheit']
            MESSAGE = "Hello #{user&.full_name}, sensor for #{sensor.name} has recorded a reading that is out of your desired range. READING: #{reading}"

            request = SendSms.call(user.sms_number, )
            render json: {status: "SUCCESS", message: 'Succesfully notified user.', data: decoded_data}, status: :ok
        rescue => e
            render json: {status: "FAIL", message: e, data: decoded_data}, status: :ok
        end
    end 
end 