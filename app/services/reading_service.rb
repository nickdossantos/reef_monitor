class ReadingService
    def self.create_reading(user, sensor, reading_data)
        # edit an existing reading column
        date = DateTime.now.in_time_zone(user.time_zone).strftime("%Y-%m-%d")
        date_with_time = DateTime.now.in_time_zone(user.time_zone)
        if reading = Reading.find_by(date: date, sensor_id: sensor.id)          
            reading.user_id = user.id            
            reading.data['readings'] << {
                'time' => date_with_time,
                'reading' => reading_data['farenheit']
            }
            reading.data['average'] = self.exact_reading_data_average_calculation(reading)
        # make a new reading col
        else            
            reading = Reading.new(user_id: user.id, sensor_id: sensor.id, tank_id: sensor.tank_id, date: date)        
            reading.data = {
                'readings' => [{
                    'time' => date_with_time,
                    'reading' => reading_data['farenheit']
                }], 
                'average' => reading_data['farenheit']
            }
        end 
        return reading
    end

    def self.create_manual_reading(user, sensor, date, hour, minute, value)
        # edit an existing reading column
        time_in_seconds = (hour.to_i * 3600) + (minute.to_i * 60)
        date_with_time = Date.parse(date).to_datetime + time_in_seconds.seconds
        if reading = Reading.find_by(date: date, sensor_id: sensor.id)          
            reading.user_id = user.id
            reading.tank_id = sensor.tank_id
            reading.data['readings'] << {
                'time' => date_with_time,
                'reading' => value
            }
            reading.data['average'] = self.exact_reading_data_average_calculation(reading)
        # make a new reading col
        else            
            reading = Reading.new(user_id: user.id, sensor_id: sensor.id, tank_id: sensor.tank_id, date: date)        
            reading.data = {
                'readings' => [{
                    'time' => date_with_time,
                    'reading' => value
                }], 
                'average' => value
            }
        end 
        return reading
    end



    def self.update_reading_data_object(reading, index, value, hour, minute)        
        reading.data['readings'][index]['reading'] = value
        reading.data['readings'][index]['time'] = self.formatted_date_params(reading.date.to_s, hour, minute)
        reading.data['average'] = self.exact_reading_data_average_calculation(reading)
        return reading
    end

    def self.formatted_date_params(date, hour, min)
        date = DateTime.parse(date)
        date = date + hour.to_i.hours
        date = date + min.to_i.minutes
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
