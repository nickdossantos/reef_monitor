class AddPinNumberToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :pin_number, :integer
    
    remove_column :devices, :post_url
    remove_column :devices, :identifier
  end
end
