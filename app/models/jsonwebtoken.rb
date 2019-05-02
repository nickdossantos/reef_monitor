class Jsonwebtoken < ApplicationRecord
    require 'jwt'
    require 'uri'


    def self.encode_for_get_device_status(user)
      # ==========================================
      # SHARED VALUE BETWEEN APPS
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
  
      # ==========================================
      # ENCRYPT
      # ==========================================
      payload = {
        auth_token: user.token,
        devices: user.devices.map {|device| {id: device.id, pin_number: device.pin_number}}
      }
      token = JWT.encode payload, hmac_secret, ENV['HASH_ALGORITHM']
      token
    end

    def self.encode_user_for_temperature_request(user, tank)
      # ==========================================
      # SHARED VALUE BETWEEN APPS
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
  
      # ==========================================
      # ENCRYPT
      # ==========================================
      payload = {
          auth_token: user.token
        }
      token = JWT.encode payload, hmac_secret, ENV['HASH_ALGORITHM']
      token
    end 

    def self.encode_device(user, device)
      # ==========================================
      # SHARED VALUE BETWEEN APPS
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
  
      # ==========================================
      # ENCRYPT
      # ==========================================
      payload = {
          auth_token: user.token,
          pin_number: device.pin_number,
          devices: user.devices.map {|device| {id: device.id, pin_number: device.pin_number}}
        }
      token = JWT.encode(payload, hmac_secret, ENV['HASH_ALGORITHM'])
      token
    end 

    def self.encode_connected_sensors(user, tank)
      hmac_secret=ENV['HMAC_SECRET']
      sensor = Sensor.find_by(hash_id: tank.temp_sensor_hash)
      payload = {
        auth_token: user.token, 
        temp_sensor_hash: tank.temp_sensor_hash, 
        high_value: sensor.high_value, 
        low_value: sensor.low_value
      }
      token = JWT.encode(payload, hmac_secret, ENV['HASH_ALGORITHM'])
      token
    end

    def self.decode(token)
      # ==========================================
      # DECRYPT
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
      decoded_data = JWT.decode(token, hmac_secret, ENV['HASH_ALGORITHM'])
      decoded_data
    end  
  end
  