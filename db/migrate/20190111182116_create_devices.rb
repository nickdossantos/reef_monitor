class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :tank_id
      t.string :identifier
      t.string :post_url

      t.timestamps
    end
  end
end
