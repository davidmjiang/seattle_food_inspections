class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.string :color
      t.string :description
      t.timestamps null: false
    end
  end
end
