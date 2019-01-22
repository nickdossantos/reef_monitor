class Jsonwebtoken < ApplicationRecord
    require 'jwt'
    require 'uri'
  
    def self.encode(user_hash, sensor_hash, value)
      # ==========================================
      # SHARED VALUE BETWEEN APPS
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
  
      # ==========================================
      # ENCRYPT
      # ==========================================
      payload = {data: {
        user: user_hash,
        sensor: sensor_hash,
        value: value
      }}
  
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
          identifier: device.hash_id
        }
      token = JWT.encode payload, hmac_secret, ENV['HASH_ALGORITHM']
      token
    end 

    def self.decode(token)
      # ==========================================
      # DECRYPT
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
      decoded_data = JWT.decode(token, hmac_secret, ENV['HASH_ALGORITHM'])
      puts decoded_data
      decoded_data
    end
  
    def self.encode_student_quiz(student_id, quiz_id)
      # ==========================================
      # SHARED VALUE BETWEEN APPS
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
  
      # ==========================================
      # ENCRYPT
      # ==========================================
      payload = {data: {
        student: student_id,
        student_quiz: quiz_id
      }}
  
      token = JWT.encode payload, hmac_secret, ENV['HASH_ALGORITHM']
      token
    end
  
    def self.decode_student_quiz(token)
      # ==========================================
      # DECRYPT
      # ==========================================
      hmac_secret=ENV['HMAC_SECRET']
      decoded_data = JWT.decode(token, hmac_secret, ENV['HASH_ALGORITHM'])
      puts decoded_data
      decoded_data
    end
  
  end
  