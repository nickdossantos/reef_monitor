class AddingTemperatureHashToTank < ActiveRecord::Migration[5.1]
  def change
    add_column :tanks, :temp_sensor_hash, :string
  end
end
