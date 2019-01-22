class DevicesController < ApplicationController
    before_action :set_device, only: [:show, :edit, :update, :destroy]
    require 'json'
    require 'net/http'

    # GET /devices
    # GET /devices.json
    def index
        @tank = @user.tanks.find(params[:tank_id])
        @devices = @tank.devices
        render layout: false
    end

    # GET /devices/1
    # GET /devices/1.json
    def show
    end

    # GET /devices/new
    def new
        @device = Device.new
        @tank = @user.tanks.find(params[:tank_id])
    end

    # GET /devices/1/edit
    def edit
        @user = User.friendly.find(params[:user_id])

        @tank = @user.tanks.find(params[:tank_id])
    end

    # POST /devices
    # POST /devices.json
    def create
        @device = Device.new(device_params)
        @device.user_id = @user.id
        respond_to do |format|
        if @device.save
            format.js { }
        else
            format.js { render :new }
            format.js { render json: @device.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /devices/1
    # PATCH/PUT /devices/1.json
    def update
        respond_to do |format|
            if @device.update(device_params)
                format.js {}
            else
                format.js { render json: @device.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /devices/1
    # DELETE /devices/1.json
    def destroy
        @device.destroy
        respond_to do |format|
            format.js { }
        end
    end

    def device_control
        @devices = @user.devices
        # post to web app route to turn off relay
        uri = URI(@user.api_endpoint << '/api/device_status')
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)
        
        res = http.request(request)
        puts res.body
        @pi_devices = JSON.parse(res.body)
    end

    def turn_on_device
        @device = Device.friendly.find(params[:device_id])
        token = Jsonwebtoken.encode_device(@user, @device)
        uri = URI(@user.api_endpoint << "/api/turn_on_device?token=" << token)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)

        res = http.request(request)
        puts res.body
        # The current status of the devices connected to the raspberry pi
        @pi_devices = JSON.parse(res.body)
    end 

    def turn_off_device        
        @device = Device.friendly.find(params[:device_id])
        token = Jsonwebtoken.encode_device(@user, @device)
        uri = URI(@user.api_endpoint << "/api/turn_off_device?token=" << token)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)

        res = http.request(request)
        puts res.body
        # The current status of the devices connected to the raspberry pi
        @pi_devices = JSON.parse(res.body)
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_device
            @device = Device.friendly.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def device_params
            params.require(:device).permit(:name, :description, :identifier, :post_url, :tank_id, :user_id)
        end
end
