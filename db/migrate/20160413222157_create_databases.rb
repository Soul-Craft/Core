class CreateDatabases < ActiveRecord::Migration[4.2]
  def change
    create_table :databases do |t|
      t.timestamps null: false
    end
  end
end
