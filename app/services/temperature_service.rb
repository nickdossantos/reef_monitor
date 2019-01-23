class TemperatureService
    require 'net/http'

    def self.record_temperature_from_pi(user, tank) 
        # get request to the pi app of the user.
        # record the response
        begin
            url = URI.parse(user.api_endpoint << "/api/get_temperature_reading?token=" << Jsonwebtoken.encode_user_for_temperature_request(user, tank))
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
            }
            data = JSON.parse(res.body)
            reading = Reading.new
            reading.user_id = user.id
            reading.sensor_id = tank.temp_sensor_id
            reading.date = data['date']
            reading.value = data['farenheit'].to_f.round(2)
            reading.tank_id = tank.id
            reading.save         
        rescue => ex
            puts(ex)
        end        
    end

    def self.get_temperature(user, tank)
        url = URI.parse(user.api_endpoint << "/api/get_temperature_reading?token=" << Jsonwebtoken.encode_user_for_temperature_request(user, tank))
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        data = JSON.parse(res.body)
        data['farenheit']
    end

end