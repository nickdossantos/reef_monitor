class RaspberryPiService
    require 'net/http'
    def self.sync_connected_sensors(user)
        begin
            token = Jsonwebtoken.encode_connected_sensors(user)
            uri = URI(user.api_endpoint << '/api/sync_sensors/all?token=' << token)
            http = Net::HTTP.new(uri.host)
            request = Net::HTTP::Post.new(uri.request_uri)
            
            res = http.request(request)
            JSON.parse(res.body)
        rescue => ex
            puts ex
        end        
    end
end