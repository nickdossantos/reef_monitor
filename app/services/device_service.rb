class DeviceService
    require 'net/http'
    def self.device_status(user, tank)
        begin
            token = Jsonwebtoken.encode_for_get_device_status(user)
            uri = URI(tank.raspberry_pi_endpoint << '/api/device_status/all?token=' << token)
            http = Net::HTTP.new(uri.host)
            request = Net::HTTP::Post.new(uri.request_uri)
            
            res = http.request(request)
            return JSON.parse(res.body)
        rescue => ex
            puts ex
        end
    end

    def self.turn_on_device_pi(user, device, tank)
        token = Jsonwebtoken.encode_device(user, device)
        uri = URI(tank.raspberry_pi_endpoint<< "/api/turn_on_device?token=" << token)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)

        res = http.request(request)
        JSON.parse(res.body)
    end
    
    def self.turn_off_device_pi(user, device, tank)
        token = Jsonwebtoken.encode_device(user, device)
        uri = URI(tank.raspberry_pi_endpoint << "/api/turn_off_device?token=" << token)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)

        res = http.request(request)
        JSON.parse(res.body)
    end
end