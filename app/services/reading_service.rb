class ReadingService
    def self.create_reading(user, date, hour, minute, value, sensor_id, tank_id)
        # edit an existing reading column
        if @reading = Reading.find_by(date: date, sensor_id: sensor_id)            
            @reading.user_id = user.id
            @reading.data['readings'] << {
                'time' => self.formatted_date_params(date, hour, minute),
                'reading' => value
            }
            @reading.data['average'] = self.exact_reading_data_average_calculation(@reading)
        # make a new reading col
        else            
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

    def self.update_reading_data_object(reading, index, value, hour, minute)        
        reading.data['readings'][index]['reading'] = value
        reading.data['readings'][index]['time'] = self.formatted_date_params(reading.date.to_s, hour, minute)
        return reading
    end

    def self.formatted_date_params(date, hour, min)
        date = DateTime.parse(date)
        date = date + hour.to_i.hours
        date = date+ min.to_i.minutes
        return date
    end

    def self.calculate_reading_data_average(current_average, new_reading_value, reading_array_length)
        return (current_average + value)/(reading_array_length)
    end

    def self.exact_reading_data_average_calculation(reading)
        total = 0                
        reading.data['readings'].each do |reading|
            total += reading['reading'].to_i
        end
        return (total/reading.data['readings'].length)
    end
end 
