require 'test_helper'

class SmsMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get send_sms" do
    get sms_messages_send_sms_url
    assert_response :success
  end

end
