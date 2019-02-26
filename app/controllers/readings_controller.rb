class ReadingsController < ApplicationController
  before_action :set_reading, only: [:show, :edit, :update, :destroy]

  # GET /readings
  # GET /readings.json
  def index
    @tank = @user.tanks.find(params[:tank_id])
    reading_data = []
    @readings = @tank.readings.includes(:sensor).order(date: :desc).limit(5)
    
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
    @tank = @user.tanks.find(params[:tank_id])
    @reading = ReadingService.format_dates(@user, params[:reading][:date], params[:hour], params[:minute], params[:value], params[:reading][:sensor_id], params[:reading][:tank_id])
    respond_to do |format|      
      if @reading.save!
        format.js { }
      else
        format.js { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /readings/1`
  # PATCH/PUT /readings/1.json
  def update
    @tank = @user.tanks.find(params[:tank_id])
    respond_to do |format|
      if @reading.update(reading_params)
        format.js { }
      else
        format.js { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_reading_data
    @reading = Reading.includes(:tank).find(params[:reading_id])
    @index = params[:index].to_i
  end 

  def update_reading_data
    # TODO REFACTOR
    @reading = Reading.includes(:tank).find(params[:reading_id])
    @data = @reading.data['readings'][params[:index].to_i]
    @tank = @reading.tank_id
    @index = params[:index].to_i
    @reading.data['readings'][params[:index].to_i]['reading'] = params['value']    
    @reading.save!
    respond_to do |format|
      format.js{ }
    end
  end 

  def destroy_data
    @reading = Reading.includes(:tank).find(params[:reading_id])
    # If user decides to delete the last reading in the set the entire Reading object will be removed. 
    @index = params[:index].to_i
    if(@index == 0)
      @reading.destroy
    else
      @reading.data['readings'].delete_at(@index)
    end

    respond_to do |format|
      format.js{ }
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
      @reading = Reading.includes(:tank).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.require(:reading ).permit(:sensor_id, :tank_id, :value, :date)
    end
end
