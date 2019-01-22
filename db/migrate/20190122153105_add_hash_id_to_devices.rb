class AddHashIdToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :hash_id, :string
    add_index :devices, :hash_id, unique: true

    Device.all.each do |a|
      a.set_hash_id
      a.save!(validate: false)
    end
  end
end
