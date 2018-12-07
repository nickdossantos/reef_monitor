class AddReadingToTank < ActiveRecord::Migration[5.1]
  def change
    add_column :readings, :tank_id, :integer
  end
end
