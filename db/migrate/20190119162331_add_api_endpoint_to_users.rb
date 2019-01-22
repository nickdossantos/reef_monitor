class AddApiEndpointToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :api_endpoint, :string
  end
end
