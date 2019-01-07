class AddHighLowValuesToSensors < ActiveRecord::Migration[5.1]
  def change
    add_column :sensors, :high_value, :float
    add_column :sensors, :low_value, :float
  end
end
