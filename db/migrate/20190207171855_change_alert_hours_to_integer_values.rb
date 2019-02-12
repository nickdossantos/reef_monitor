class ChangeAlertHoursToIntegerValues < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :email_notification_hour
    remove_column :users, :sms_notification_hour

    add_column :users, :email_notification_hour, :integer, :default => 0
    add_column :users, :sms_notification_hour, :integer, :default => 0
  end
end
