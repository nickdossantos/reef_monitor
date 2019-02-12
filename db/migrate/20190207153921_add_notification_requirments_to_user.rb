class AddNotificationRequirmentsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_notification_frequency, :integer, :default => 0
    add_column :users, :sms_notification_frequency, :integer, :default => 0

    add_column :users, :email_notification_hour, :string, :default => ""
    add_column :users, :sms_notification_hour, :string, :default => ""
  end
end
