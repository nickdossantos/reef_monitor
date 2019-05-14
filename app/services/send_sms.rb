class SendSms < SmsObject
    def initialize(recipient, message)
        @recipient = recipient
        @message = message
    end

    def call
        errors.add :base, "Missing recipient's number." if @recipient.empty?
        errors.add :base, "Missing message to recipient." if @message.empty?
        send_message unless errors.any?
    end

    private

    def send_message
        request = Clients::Twilio.call(@recipient, @message)
        errors.add_multiple_errors(request.errors) if request.failure?
        request
    end
end
