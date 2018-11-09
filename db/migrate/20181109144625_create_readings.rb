class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.integer :sensor_id
      t.float :value
      t.integer :user_id

      t.timestamps
    end
  end
end
