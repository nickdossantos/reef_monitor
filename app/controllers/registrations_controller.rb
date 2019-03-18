class RegistrationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    def new 
        @user = User.new
        render layout: 'authentication'
    end

    def create
        @user = User.new(user_params)
        @user.token = generate_auth_token()
        if @user.save
            sign_in @user
            redirect_to pages_tanks_path()
        else
            format.js { render :new }
            format.js { render json: @user.errors, status: :unprocessable_entity }
        end
    end

    def generate_auth_token
        token = SecureRandom.hex
        loop do
          token = SecureRandom.hex
          break unless @user.class.name.constantize.where(:token => token).exists?
        end
        return token
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :sms_number, :time_zone, :api_endpoint, :email_notification_frequency, :sms_notification_frequency, :email_notification_hour, :sms_notification_hour, :password_confirmation, :password)
    end
end
