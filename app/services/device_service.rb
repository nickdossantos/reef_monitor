class DeviceService
    require 'net/http'
    def self.device_status(user)
        # post to web app route to turn off relay
        uri = URI(user.api_endpoint << '/api/device_status')
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)
        
        res = http.request(request)
        JSON.parse(res.body)
    end

    def self.turn_on_device_pi(user, device)
        token = Jsonwebtoken.encode_device(user, device)
        uri = URI(user.api_endpoint << "/api/turn_on_device?token=" << token)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)

        res = http.request(request)
        JSON.parse(res.body)
    end
    
    def self.turn_off_device_pi(user, device)
        token = Jsonwebtoken.encode_device(user, device)
        uri = URI(user.api_endpoint << "/api/turn_off_device?token=" << token)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(uri.request_uri)

        res = http.request(request)
        JSON.parse(res.body)
    end
end