class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :report_type
      t.jsonb :report_data, :default => {}
      t.integer :user_id

      t.timestamps
    end
  end
end
