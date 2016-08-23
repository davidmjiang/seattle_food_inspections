class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :inspections, :restaurant_id, :integer
    add_column :violations, :restaurant_id, :integer
  end
end
