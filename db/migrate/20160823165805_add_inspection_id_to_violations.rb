class AddInspectionIdToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :inspection_id, :integer
    remove_column :violations, :restaurant_id
  end
end
