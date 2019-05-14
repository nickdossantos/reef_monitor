class RemoveApiEndpointFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :sms_notification_hour  
  end
end
