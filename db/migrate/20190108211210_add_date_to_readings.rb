class AddDateToReadings < ActiveRecord::Migration[5.1]
  def change
    add_column :readings, :date, :datetime
  end
end
