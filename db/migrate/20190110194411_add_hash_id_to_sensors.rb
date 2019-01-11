class AddHashIdToSensors < ActiveRecord::Migration[5.1]
  def change
    add_column :sensors, :hash_id, :string
    add_index :sensors, :hash_id, unique: true

    Sensor.all.each do |a|
      a.set_hash_id
      a.save!(validate: false)
    end
  end
end
