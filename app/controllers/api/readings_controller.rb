class Api::ReadingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :decode_token, only: [:create]
    
    def create
        render json: {status: "SUCCESS", message: 'Your token has been decoded', data: @decoded_data}, status: :ok
    end 

    private
    def decode_token
       @decoded_data = Jsonwebtoken.decode(params[:token])
    end 
end