class DevicesController < ApplicationController
    before_action :set_device, only: [:show, :edit, :update, :destroy]

    # GET /devices
    # GET /devices.json
    def index
        @devices = @user.devices
    end

    # GET /devices/1
    # GET /devices/1.json
    def show
    end

    # GET /devices/new
    def new
        @device = Device.new
    end

    # GET /devices/1/edit
    def edit
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

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_device
            @device = Device.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def device_params
            params.require(:device).permit(:name, :description, :identifier, :post_url, :tank_id, :user_id)
        end
end