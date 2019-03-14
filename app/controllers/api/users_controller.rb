class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    
    
    def verify_pin_number
        begin 
            # do something with the pin numbers.
            # Todo also need to generate the pin numbers and associate them with an account. 
            render json: {status: "SUCCESS", message: 'Your token has been decoded.'}, status: :ok
        rescue => e 
            render json: {status: "FAIL", message: e}, status: :ok
        end
        
    end 

end