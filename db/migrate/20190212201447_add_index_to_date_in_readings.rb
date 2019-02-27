class AddIndexToDateInReadings < ActiveRecord::Migration[5.1]
  def change
    add_index :readings, :date, unique: true
  end
end
