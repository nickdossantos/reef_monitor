class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    
    
    def verify_pin_number
        begin 
            pin_number = params[:pin_number]
            api_endpoint = params[:api_endpoint]
            user = User.find_by(temporary_pin_token: params[:pin_number])
            user.temporary_pin_token = pin_number
            user.api_endpoint = api_endpoint
            user.save
            # do something with the pin numbers.
            # Todo also need to generate the pin numbers and associate them with an account. 
            render json: {status: "SUCCESS", message: 'Your token has been decoded.'}, status: :ok
        rescue => e 
            render json: {status: "FAIL", message: e}, status: :ok
        end
        
    end 

end