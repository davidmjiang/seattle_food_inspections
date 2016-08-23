class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.date :date
      t.integer :score
      t.string :result
      t.timestamps null: false
    end
  end
end
