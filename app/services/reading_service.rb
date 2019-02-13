class ReadingService
    def self.format_dates(user,date, hour, minute, value)
        if @reading = Reading.find_by(date: date)
            # edit an existing reading column
            @reading.user_id = user.id
            readings_data = @reading.data
            readings_data = readings_data['readings'] << {
                'time' => self.formatted_date_params(date, hour, minute),
                'reading' => value
            }
            @reading.data['readings'] = readings_data
            else
            # make a new reading col
            @reading = Reading.new(reading_params)
            @reading.user_id = user.id
            @reading.data = {
                'readings' => [
                {
                    'time' => formatted_date_params(date, hour, minute),
                    'reading' => value
                }
                ]
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
