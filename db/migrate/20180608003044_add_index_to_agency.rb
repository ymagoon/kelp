class AddIndexToAgency < ActiveRecord::Migration[5.2]
  def change
    add_index :agencies, [:store_number, :training_organization_id], unique: true
  end
end
