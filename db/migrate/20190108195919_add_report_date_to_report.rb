class AddReportDateToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :report_date, :datetime 
  end
end
