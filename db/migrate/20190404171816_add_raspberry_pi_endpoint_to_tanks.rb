class AddRaspberryPiEndpointToTanks < ActiveRecord::Migration[5.1]
  def change
    add_column :tanks, :raspberry_pi_endpoint, :string
  end
end
