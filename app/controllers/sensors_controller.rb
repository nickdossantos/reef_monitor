class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]
  before_action :format_dates, only: [:get_graph_data_with_range, :graph, :sensor_reading_data, :graphs_with_date_range]

  # GET /sensors
  # GET /sensors.json
  def index
    @tank = @user.tanks.includes(:sensors).find(params[:tank_id])    
    render layout: false
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    @readings = @sensor.readings.includes(:tank).page params[:page]
    @reading = @user.readings.new
    @tank = @user.tanks.find(params[:tank_id])
  end

  # GET /sensors/new
  def new
    @tank = @user.tanks.find(params[:tank_id])
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @tank = @user.tanks.find(params[:tank_id])
    @sensor = Sensor.new(sensor_params)
    @sensor.user_id = @user.id
    respond_to do |format|
      if @sensor.save
        format.js { }
      else
        format.js { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    @tank = @user.tanks.find(params[:tank_id])
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.js { }

      else
        format.js { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor.destroy
    respond_to do |format|
      format.js { }
    end
  end

  def sensor_reading_data
    @sensor = Sensor.friendly.find(params[:sensor_id])
    data = get_graph_data_with_range
      render json: Reading.send(data['method_name'], *data['opts']).where("user_id = ? AND sensor_id = ?", @user.id, @sensor.id).average("CAST(data->>'average' AS integer)")
  end

  # Graph with date ranges
  def graphs_with_date_range
    @sensor = Sensor.friendly.find(params[:sensor_id])
    data = get_graph_data_with_range
    # if hourly view rework query.
    #   Enter query here. 
    # else standard view for readings w only averages.
    if data['method_name'] == :group_by_hour_of_day
      # get the obj iterate of the data, group by hour over value. 
      # @sensor_param_data = Reading.send(data['method_name'], *data['opts']).where("user_id = ? AND sensor_id = ?", @user.id, @sensor.id).average("CAST(data->>'average' AS integer)")
      @reading = Reading.find_by(date: params[:datepickerEnd])
      @reading.data['readings'].data['method_name'].group('value')
    else
      # fix below query to stop averaging the average. 
      @sensor_param_data = Reading.send(data['method_name'], *data['opts']).where("user_id = ? AND sensor_id = ?", @user.id, @sensor.id).average("CAST(data->>'average' AS integer)")
    end 
  end

  # Show Graph for sensors
  def graph
    @sensor = Sensor.friendly.find(params[:sensor_id])
    @tank = @user.tanks.find(params[:tank_id])

    @temp_data = {
      'readings' => [{
        'hour' => 8,
        'reading' => 78 
      },
      {
        'hour' => 9,
        'reading'=> 78 
      }
       ],
      'average'=> 78
    }
    @temp_data.to_json
  end

  def get_graph_data_with_range
    opts = ['date', {range: @start_date..@end_date, series: false}]
    method_name = :group_by_day
    # Dynamically changes the syle grouping of the graph Ex. Hour, Day, Month, Year
    if @end_date.at_end_of_day == @start_date.at_end_of_day
       opts[1].merge!({format: '%Y%m%d %H'})
       method_name = :group_by_hour_of_day
    elsif @end_date - (1.year + 2.days) > @start_date
      opts[1].merge!({format: '%Y'})
      method_name = :group_by_year
    elsif @end_date - (3.month + 2.days) > @start_date
      opts[1].merge!({format: '%b %Y'})
      method_name = :group_by_month
    end
    charts_data = {'method_name' => method_name, 'opts'=> opts}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:name, :goal_value, :tank_id, :high_value, :low_value)
    end

    def format_dates
      @start_date = params[:datepickerStart].nil? || params[:datepickerStart].empty? ?
          1.month.ago.midnight :
          Date.strptime(params[:datepickerStart], "%m/%d/%Y").to_datetime.midnight
      @end_date = params[:datepickerEnd].nil? || params[:datepickerEnd].empty? ?
          Time.now.in_time_zone(@user.time_zone).at_end_of_day :
          Date.strptime(params[:datepickerEnd], "%m/%d/%Y").to_datetime.at_end_of_day
      @start_date, @end_date = @end_date, @start_date if @end_date < @start_date
    end
end
