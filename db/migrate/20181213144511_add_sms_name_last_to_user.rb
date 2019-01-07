class AddSmsNameLastToUser < ActiveRecord::Migration[5.1]
  def change
    def change
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
      add_column :users, :sms_number, :string
    end
  end
end
