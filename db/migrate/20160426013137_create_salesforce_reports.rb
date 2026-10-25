class CreateSalesforceReports < ActiveRecord::Migration[4.2]
  def change
    create_table :salesforce_reports do |t|
      t.integer :org_id
      t.string :name
      t.string :report_id
      t.timestamps null: false
    end
  end
end
