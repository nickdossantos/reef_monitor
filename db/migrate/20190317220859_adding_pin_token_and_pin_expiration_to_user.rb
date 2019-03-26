class AddingPinTokenAndPinExpirationToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :temporary_pin_token, :string
    add_column :users, :temporary_pin_token_expiration_date, :datetime
  end
end
