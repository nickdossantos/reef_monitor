class AddDataToReadingsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :readings, :data, :jsonb, :default => {}
  end
end
