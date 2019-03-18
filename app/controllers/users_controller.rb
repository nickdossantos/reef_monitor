class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = @user.users
    render layout: false
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
    render layout: 'authentication'
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = user.new(user_params)
    respond_to do |format|
      if @user.save
        format.js { }
      else
        format.js { render :new }
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.js {}
      else
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.js { }
    end
  end

  def raspberry_pi
    @user = User.friendly.find(params[:user_id])
  end 

  def notifications
    @user = User.friendly.find(params[:user_id])
  end

  def generate_temporary_pin_token
    @user = User.friendly.find(params[:user_id])
    pin_token = SecureRandom.hex(3)
    loop do
      pin_token = SecureRandom.hex(3)
      break unless @user.class.name.constantize.where(:temporary_pin_token => pin_token).exists?
    end
    @user.temporary_pin_token = pin_token
    @user.temporary_pin_token_expiration_date = Time.now.in_time_zone(@user.time_zone) + 1.day
    begin
      @user.save  
    rescue => exception
      puts exception
    end
  end 

  def turn_off_relay 
    @user = User.friendly.find(params[:user_id])
    # post to web app route to turn off relay
    require 'net/http'
    uri = URI('http://453a36c8.ngrok.io/api/turn_off_relay')
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)
    
    res = http.request(request)
    puts res.body
  end

  def turn_on_relay
    @user = User.friendly.find(params[:user_id])
    # post to web app route to turn off relay
    require 'net/http'
    uri = URI('http://453a36c8.ngrok.io/api/turn_on_relay')
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)
    
    res = http.request(request)
    puts res.body
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :sms_number, :time_zone, :api_endpoint, :email_notification_frequency, :sms_notification_frequency, :email_notification_hour, :sms_notification_hour)
    end
end
