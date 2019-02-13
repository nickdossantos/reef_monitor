class ReadingsController < ApplicationController
  before_action :set_reading, only: [:show, :edit, :update, :destroy]

  # GET /readings
  # GET /readings.json
  def index
    @tank = @user.tanks.find(params[:tank_id])
    @readings = @tank.readings.includes(:sensor).order(created_at: :desc).limit(15)    
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
    # TODO
    # delagate to service object
    @tank = @user.tanks.find(params[:tank_id])
    if @reading = Reading.find_by(date: params[:reading][:date])
      # edit an existing reading column
      @reading.user_id = @user.id
      readings_data = @reading.data
      readings_data = readings_data['readings'] << {
        'time' => formatted_date_params(params[:reading][:date], params[:hour], params[:minute]),
        'reading' => params[:reading][:value]
      }
      @reading.data['readings'] = readings_data
    else
      # make a new reading col
      @reading = Reading.new(reading_params)
      @reading.user_id = @user.id
      @reading.data = {
        'readings' => [
          {
            'time' => formatted_date_params(params[:reading][:date], params[:hour], params[:minute]),
            'reading' => params[:reading][:value]
          }
        ]
      }
    end 
    respond_to do |format|
      if @reading.save
        format.js { }
      else
        format.js { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  def formatted_date_params(date, hour, min)
    date = DateTime.parse(date)
    date = date + hour.to_i.hours
    date = date+ min.to_i.minutes
    return date
  end
  # PATCH/PUT /readings/1
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
