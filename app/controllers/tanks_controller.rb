class TanksController < ApplicationController
  before_action :set_tank, only: [:show, :edit, :update, :destroy]

  # GET /tanks
  # GET /tanks.json
  def index
    @tanks = @user.tanks    
    render layout: false
  end

  # GET /tanks/1
  # GET /tanks/1.json
  def show
  end

  # GET /tanks/new
  def new
    @tank = Tank.new
  end

  # GET /tanks/1/edit
  def edit
  end

  # POST /tanks
  # POST /tanks.json
  def create
    @tank = Tank.new(tank_params)
    @tank.user_id = @user.id
    respond_to do |format|
      if @tank.save
        format.js { }
      else
        format.js { render :new }
        format.js { render json: @tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tanks/1
  # PATCH/PUT /tanks/1.json
  def update
    # need to update the pi so it knows that sensor's pin to read data from. 
    # send a post request to the pi with the updated sensor
    respond_to do |format|
      if @tank.update(tank_params)
        format.js {}
      else
        format.js { render json: @tank.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_tank_sensors
    tank = Tank.find(params[:tank_id])
    user = User.friendly.find(params[:user_id])
    if user.has_api_configured?
      RaspberryPiService.sync_connected_sensors(user, tank)
    end 
    respond_to do |format|
      if tank.update(tank_params)
        format.js {}
      else
        format.js { render json: @tank.errors, status: :unprocessable_entity }
      end
    end
  end 

  def reaspberry_pi
    @tank = @user.tanks.find(params[:tank_id])
  end

  def temperature_widget
    @tank = @user.tanks.find(params[:tank_id])
    @temperature_data = TemperatureService.get_temperature(@user, @tank)
    if !@temperature_data
      flash[:error] = "Could not access pi's temperature sensor."      
    end
    render layout: false 
  end

  # DELETE /tanks/1
  # DELETE /tanks/1.json
  def destroy
    @tank.destroy
    respond_to do |format|
      format.js { }
    end
  end

  def tank_sensors
    @tank = @user.tanks.includes(:sensors).find(params[:tank_id])
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tank
      @tank = Tank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tank_params
      params.require(:tank).permit(:name, :description, :temp_sensor_id, :temp_sensor_pin, :temp_sensor_hash)
    end
end
