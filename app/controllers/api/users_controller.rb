class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    def verify_pin_number
        begin 
            pin_number = params[:pin_number]
            api_endpoint = params[:api_endpoint]
            user = User.find_by(temporary_pin_token: pin_number)
            if user.temporary_pin_token_expiration_date < Time.now.in_time_zone(user.time_zone)
                render json: {status: "Fail", message: 'Your pin token has expired.'}, status: :ok
            else
                user.temporary_pin_token = pin_number
                user.api_endpoint = api_endpoint
                user.save
                render json: {status: "SUCCESS", message: 'Your Raspbeery Pi has been authenticated.', token: user.token}.to_json
            end
        rescue => e 
            render json: {status: "FAIL", message: e}, status: :ok
        end
    end 
end