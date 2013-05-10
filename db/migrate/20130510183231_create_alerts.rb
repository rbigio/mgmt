class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :milestone
      t.string :alert_type
      t.decimal :metric

      t.timestamps
    end
  end
end
