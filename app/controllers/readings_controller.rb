class ReadingsController < ApplicationController
  before_action :set_reading, only: [:show, :edit, :update, :destroy]

  # GET /readings
  # GET /readings.json
  def index
    @tank = @user.tanks.find(params[:tank_id])
    @readings = @tank.readings.order(created_at: :desc).limit(25)
    render layout: false
  end

  # GET /readings/1
  # GET /readings/1.json
  def show
  end

  # GET /readings/new
  def new
    @tank = @user.tanks.find(params[:tank_id])
    @reading = Reading.new
  end

  # GET /readings/1/edit
  def edit
  end

  # POST /readings
  # POST /readings.json
  def create
    @reading = Reading.new(reading_params)
    @reading.user_id = @user.id
    respond_to do |format|
      if @reading.save
        format.js { }
      else
        format.js { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /readings/1
  # PATCH/PUT /readings/1.json
  def update
    respond_to do |format|
      if @reading.update(reading_params)
        format.js { }
      else
        format.js { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.json
  def destroy
    @reading.destroy
    respond_to do |format|
      format.js{ }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reading
      @reading = Reading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.require(:reading ).permit(:sensor_id, :tank_id, :value, :date)
    end
end
