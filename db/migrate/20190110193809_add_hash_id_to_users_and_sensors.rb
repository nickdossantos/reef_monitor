class AddHashIdToUsersAndSensors < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hash_id, :string
    add_index :users, :hash_id, unique: true

    User.all.each do |a|
      a.set_hash_id
      a.save!(validate: false)
    end
  end
end
