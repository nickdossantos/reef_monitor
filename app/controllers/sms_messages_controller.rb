class SmsMessagesController < ApplicationController
  def send_sms
    message = "Hello this is a test."
    number = @user.sms_number
    request = SendSms.call(number, message)

    respond_to do |format|
      if request.success?
        format.js {}
      elsif request.failure?
        format.js {
          render partial: 'shared/errors', locals: {obj: request}, status: :unprocessable_entity
        }
      end
    end
  end
end
