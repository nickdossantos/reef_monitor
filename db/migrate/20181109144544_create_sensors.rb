class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :name
      t.float :goal_value
      t.integer :tank_id
      t.integer :user_id

      t.timestamps
    end
  end
end
