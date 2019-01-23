class DevicesController < ApplicationController
    before_action :set_device, only: [:show, :edit, :update, :destroy]

    # GET /devices
    # GET /devices.json
    def index
        @tank = @user.tanks.includes(:devices).find(params[:tank_id])
        render layout: false
    end

    # GET /devices/1
    # GET /devices/1.json
    def show
    end

    # GET /devices/new
    def new
        @tank = @user.tanks.find(params[:tank_id])
        @device = Device.new
    end

    # GET /devices/1/edit
    def edit
        @user = User.friendly.find(params[:user_id])

        @tank = @user.tanks.find(params[:tank_id])
    end

    # POST /devices
    # POST /devices.json
    def create
        @tank = @user.tanks.find(params[:tank_id])
        @device = Device.new(device_params)
        @device.user_id = @user.id
            respond_to do |format|
            if @device.save
                format.js { }
            else
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
        @pi_devices = DeviceService.device_status(@user)
    end

    def turn_on_device
        @device = Device.friendly.find(params[:device_id])
        # Turns on device on pi and gets status of devices.
        @pi_devices = DeviceService.turn_on_device_pi(@user, @device)
    end 

    def turn_off_device        
        @device = Device.friendly.find(params[:device_id])
        # Turns off device on pi and gets status of devices.
        @pi_devices = DeviceService.turn_off_device_pi(@user, @device)
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
