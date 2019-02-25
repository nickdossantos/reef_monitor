class ReadingService
    def self.format_dates(user, date, hour, minute, value, sensor_id, tank_id)
        if @reading = Reading.find_by(date: date, sensor_id: sensor_id)
            # edit an existing reading column
            @reading.user_id = user.id
            @reading.data['readings'] << {
                'time' => self.formatted_date_params(date, hour, minute),
                'reading' => value
            }
            @reading.data['average'] = (@reading.data['average'].to_i + value.to_i)/(@reading.data['readings'].length)
            else
            # make a new reading col
            @reading = Reading.new(user_id: user.id, sensor_id: sensor_id, value: value, tank_id: tank_id, date: date)        
            @reading.data = {
                'readings' => [{
                    'time' => formatted_date_params(date, hour, minute),
                    'reading' => value
                }], 
                'average' => value
            }
        end 
        return @reading
    end 

    def self.formatted_date_params(date, hour, min)
        date = DateTime.parse(date)
        date = date + hour.to_i.hours
        date = date+ min.to_i.minutes
        return date
    end
end 
