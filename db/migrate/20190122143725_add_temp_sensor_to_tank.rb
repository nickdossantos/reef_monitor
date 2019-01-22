class AddTempSensorToTank < ActiveRecord::Migration[5.1]
  def change
    add_column :tanks, :temp_sensor_id, :integer
    add_column :tanks, :temp_sensor_pin, :integer
  end
end
