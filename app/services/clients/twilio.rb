require 'twilio-ruby'
module Clients
  class Twilio < SmsObject
    PHONE_NUMBER = '+14133142770'

    def initialize(recipient, message)
      @recipient = recipient
      @message = message
    end

    def call
      send_message
    end

    private

    def send_message
      account_id = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @client = ::Twilio::REST::Client.new account_id, auth_token
      @client.api.account.messages.create(
        from: PHONE_NUMBER,
        to: @recipient,
        body: @message
      )
      @client
    rescue ::Twilio::REST::RestError => error
      errors.add :sms, error.message
    end
  end
end
