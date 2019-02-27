class RemoveingValueColumnFromReadingsTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :readings, :value
  end
end
