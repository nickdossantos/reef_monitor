class TemporaryRemovalReadingDateIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :readings, :date
    add_index :readings, :date
    # removed index then added again, date was unique which now is not the case.
    # Ex each reading sensor_id pair will be unique. DB won't handle.
  end
end
